import { Schema, model } from "mongoose";

const groupSchema = new Schema(
  {
    gNumber: {
      type: String,
      require: true,
      unique: true,
    },
    medium: {
      type: String,
      require: true,
    },
    quantity: {
      type: Number,
      require: true,
    },
  },
  {
    timestamps: true,
    versionKey: false,
  }
);

export default model("Group", groupSchema);
