import { Schema, model } from "mongoose";

const userSchema = new Schema(
  {
    name: {
      type: String,
      require: true
    },
    last_name: {
      type: String,
      require: true,
    },
    username: {
      type: String,
      require: true,
    },
    password: {
      type: String,
      require: true,
    },
    ci: {
      type: String,
      require: true,
    },
    phoneNumber: {
      type: Number,
      require: true,
    },
  },
  {
    timestamps: true,
    versionKey: false,
  }
);

export default model("User", userSchema);



