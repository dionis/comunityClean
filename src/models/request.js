import { Schema, model } from "mongoose";

const requestSchema = new Schema(
  {
    amountGarbage: {
      type: Number,
    },
    stat: {
      type: Boolean,
      default: false,
    },
    image_url: String,
    locations: {
      type: String,
    },
  },
  {
    timestamps: true,
    versionKey: false,
  }
);

export default model("collectRequest", requestSchema);
