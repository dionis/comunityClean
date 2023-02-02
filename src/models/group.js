import { Schema, model } from "mongoose";

const groupSchema = new Schema(
  {
    gNumber: {
      type: Number,
    },
    medium: {
      type: String,
    },
    quantity: {
      type: Number,
    },
  },
  {
    timestamps: true,
    versionKey: false,
  }
);

export default model("Group", groupSchema);
