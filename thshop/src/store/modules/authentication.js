import axios from "@/plugins/axios";
import router from "@/router/index";

export default {
  state: {
    isAuthenticated: false,
    jwt: null,
    user: null,
    apps: [],
  },
  mutations: {
    SET_AUTHENTICATED(state, isAuthenticated) {
      state.isAuthenticated = isAuthenticated;
    },
    SET_JWT(state, jwt) {
      localStorage.setItem("jwt.token", jwt);
      state.jwt = jwt;
    },
    REMOVE_JWT(state) {
      localStorage.removeItem("jwt.token");
      state.jwt = null;
    },
    SET_USER(state, user) {
      state.user = user;
    },
    SET_APPS(state, apps) {
      state.apps = apps;
    },
  },
  actions: {
    autologin({ commit }, jwtToken) {
      commit("SET_AUTHENTICATED", true);
      commit("SET_JWT", jwtToken);
    },
    async login({ commit }, payload) {
      const loginRes = await axios.post("/auth/login", payload);
      commit("SET_AUTHENTICATED", true);
      commit("SET_JWT", loginRes.data.token);
      return loginRes.data;
    },
    logout({ commit }) {
      commit("SET_AUTHENTICATED", false);
      commit("SET_USER", null);
      commit("REMOVE_JWT");
      router.push({ name: "start" });
    },
    async setApps({ commit, getters }) {
      // fetch public apps if not authenticated
      let apps = [];
      if (getters.isAuthenticated) apps = await axios.get("/user/apps");
      else apps = await axios.get("/public/apps");
      // commit new apps to mutations
      commit("SET_APPS", apps.data.apps);
    },
    async registration(_, payload) {
      const registrationRes = await axios.post("/auth/registration", payload);
      return registrationRes.data;
    },
  },
  getters: {
    isAuthenticated(state) {
      return state.isAuthenticated;
    },
    getUser(state) {
      return state.user;
    },
    getApps(state) {
      return state.apps;
    },
  },
};
