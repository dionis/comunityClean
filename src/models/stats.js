import { Schema, model, ObjectId } from "mongoose";

const statSchema = new Schema(
  {
    addressQ: {
      type: Number,
    },
    pendingPicks: {
      type: Number,
    },
    donePicks: {
      type: Number,
    },
    workerQ: {
      type: Number,
    },
  },
  {
    timestamps: true,
    versionKey: false,
  }
);

export default model("stats", statSchema);
