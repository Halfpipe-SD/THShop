<template>
  <div>
    <v-col></v-col>
    <v-card :loading="formLogin.loading" class="mx-auto" max-width="500">
      <template slot="progress">
        <v-progress-linear
          color="deep-purple"
          height="10"
          indeterminate
        ></v-progress-linear>
      </template>
      <v-card-title>Login to your account</v-card-title>
      <v-card-text>
        <v-text-field
          v-model="formLogin.username"
          type="text"
          name="input-10-1"
          label="Username"
        ></v-text-field>
        <v-text-field
          v-model="formLogin.password"
          type="password"
          name="input-10-1"
          label="Password"
        ></v-text-field>
      </v-card-text>
      <v-card-actions>
        <v-spacer></v-spacer>
        <v-btn text @click="login">Login</v-btn>
      </v-card-actions>
    </v-card>

    <v-col></v-col>

    <v-card :loading="formRegister.loading" class="mx-auto" max-width="500">
      <template slot="progress">
        <v-progress-linear
          color="deep-purple"
          height="10"
          indeterminate
        ></v-progress-linear>
      </template>
      <v-card-title>Register your account</v-card-title>
      <v-card-text>
        <v-text-field
          v-model="formRegister.username"
          type="text"
          name="input-10-1"
          label="Username"
        ></v-text-field>
        <v-text-field
          v-model="formRegister.password"
          type="password"
          name="input-10-1"
          label="Password"
          hint="At least 8 characters"
          counter
        ></v-text-field>
        <v-text-field
          v-model="formRegister.password2"
          type="password"
          name="input-10-1"
          label="Confirm Password"
          hint="At least 8 characters"
          counter
        ></v-text-field>
      </v-card-text>
      <v-card-actions>
        <v-spacer></v-spacer>
        <v-btn text @click="registration">Register</v-btn>
      </v-card-actions>
    </v-card>
    <v-snackbar v-model="snackbar.show" :timeout="snackbar.timeout" multi-line
      >{{ snackbar.text }}
      <template v-slot:action="{ attrs }">
        <v-btn text v-bind="attrs" @click="snackbar = false">Close </v-btn>
      </template>
    </v-snackbar>
  </div>
</template>

<script>
export default {
  data() {
    return {
      snackbar: {
        show: false,
        timeout: 2000,
        text: "",
      },
      formLogin: {
        loading: false,
        password: "",
        username: "",
      },
      formRegister: {
        loading: false,
        password: "",
        password2: "",
        username: "",
      },
    };
  },
  created() {
    if (this.$store.getters.isAuthenticated) {
      this.$router.push({ name: "home" });
    }
  },
  methods: {
    login() {
      this.formLogin.loading = true;
      this.$store
        .dispatch("login", {
          username: this.formLogin.username,
          password: this.formLogin.password,
        })
        .then(() => this.$router.push({ name: "home" }))
        .catch((error) => this.showSnackbar(error.response.data.message))
        .finally(() => (this.formLogin.loading = false));
    },
    registration() {
      if (this.formRegister.password === this.formRegister.password2) {
        this.formRegister.loading = true;
        this.$store
          .dispatch("registration", {
            username: this.formRegister.username,
            password: this.formRegister.password,
          })
          .then((data) => {
            this.showSnackbar(data.message);
          })
          .catch((error) => this.showSnackbar(error.response.data.message))
          .finally(() => (this.formRegister.loading = false));
      } else this.showSnackbar("Error: Passwords do not match!");
    },
    showSnackbar(text) {
      this.snackbar.text = text;
      this.snackbar.show = true;
    },
  },
};
</script>

<style></style>
