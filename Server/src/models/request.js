import { Schema, model, ObjectId } from "mongoose";
import user from "./user";

const requestSchema = new Schema(
  {
    user: {
      type: String,
      ref: user,
    },
    amountGarbage: {
      type: Number,
    },
    // Stat es si fue realizada o no, default en falso porque 
    // no se ha cumplido la solicitud
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
