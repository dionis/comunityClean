import { Schema, model } from "mongoose";

const userSchema = new Schema(
  {
    name: {
      type: String,
    },
    last_name: {
      type: String,
    },
    username: {
      type: String,
    },
    password: {
      type: String,
    },
    ci: {
      type: String
    },
    phoneNumber: {
      type: Number,
    },
  },
  {
    timestamps: true,
    versionKey: false,
  }
);

export {userSchema}
export default model("User", userSchema);



