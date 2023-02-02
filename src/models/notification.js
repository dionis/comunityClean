import { Schema, model } from "mongoose";

const notificationSchema = new Schema(
  {
    message: {
      type: String,
    },
    isSended: {
      type: Boolean,
      default: false,
    },
    isRecived: {
      type: Boolean,
      default: false,
    },
  },
  {
    timestamps: true,
    versionKey: false,
  }
);

export default model("notification", notificationSchema);
