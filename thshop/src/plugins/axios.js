import axios from "axios";
import store from "@/store/index";

const api = axios.create({
  baseURL: String(process.env.VUE_APP_BASE_URL),
});

api.interceptors.request.use((config) => {
  const token = localStorage.getItem("jwt.token");

  if (config && config.headers && token !== null)
    config.headers.Authorization = "Bearer " + token;

  return config;
});

api.interceptors.response.use(
  (success) => {
    return success;
  },
  (failure) => {
    // logout if token is invalid
    if (failure.response.status === 401) store.dispatch("logout");

    return Promise.reject(failure);
  }
);

export default api;
