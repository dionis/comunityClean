import { Schema, model, index } from "mongoose";
import { userSchema } from "./user";
const workerSchema = new Schema(
    {
        user: userSchema,
        isBoss: {
            type: Boolean,
        },
        gNumber: {
            type: Number
        },
    },
    {
        timestamps: true,
        versionKey: false,
    }
);

export default model("Worker", workerSchema);
