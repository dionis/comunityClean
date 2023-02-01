import express, { Router } from "express";
import Stats from "../models/stats";
import Group from "../models/group";
import Request from "../models/request";

const stats = Router();
stats.use(express.json());

stats.post("/api/v1/stats", async (req, res) => {
  try {
    const newStat = Stats(await generateStat());
    const savedStat = await newStat.save();
    res.send(savedStat);
  } catch (error) {
    res.send(error);
  }
});

stats.get("/api/v1/stats", async (req,res)=>{
    try{
        const allStats = await Stats.find();
        res.send(allStats)
    }catch(e){
        console.log(e);
        res.send(e)
    }
});

const generateStat = async () => {
  const addressQ = await Request.count();

  const pendingPicks = await Request.count({ stat: false });

  const donePicks = await Request.count({ stat: true });

  const workerQ = await Group.aggregate([
    { $group: { _id: null, quantity: { $sum: "$quantity" } } },
  ]);

  const workerQuantity = workerQ[0].quantity;
  return { addressQ, pendingPicks, donePicks, workerQuantity };
};

export default stats;
