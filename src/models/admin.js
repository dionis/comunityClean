import { Schema, model } from "mongoose";
import { userSchema } from "./user";
const adminSchema = new Schema(
  {
    user: userSchema,
    local: {
      type: String,
    },
    medium: {
      type: String,
    },
  },
  {
    timestamps: true,
    versionKey: false,
  }
);

export default model("Admin", adminSchema);
