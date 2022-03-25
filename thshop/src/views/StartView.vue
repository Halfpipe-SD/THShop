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
  </div>
</template>

<script>
export default {
  data() {
    return {
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
  methods: {
    login() {
      this.$store
        .dispatch("login", {
          username: this.formLogin.username,
          password: this.formLogin.password,
        })
        .then(() => {
          this.$router.push({ name: "home" });
        })
        .finally(() => (this.formRegister.loading = false));
    },
    registration() {
      if (this.formRegister.password !== this.formRegister.password2) {
        console.log("Passwords do not match");
        return;
      }
      this.formRegister.loading = true;
      this.$store
        .dispatch("registration", {
          username: this.formRegister.username,
          password: this.formRegister.password,
        })
        .then(() => {
          this.$router.push({ name: "home" });
        })
        .finally(() => (this.formRegister.loading = false));
    },
  },
  created() {
    if (this.$store.getters.isAuthenticated) {
      this.$router.push({ name: "home" });
    }
  },
};
</script>

<style></style>
