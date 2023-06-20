import express,{ Router } from 'express';
import Stripe from 'stripe';
import dotenv from 'dotenv';
dotenv.config()

const payment = Router()
payment.use(express.json())
const stripe = new Stripe(process.env.APIKEY)

payment.post('/create-checkout', async (req, res) => {
    const { quantity } = req.body;
    const session = await stripe.checkout.sessions.create({
        line_items: [
            {
                price_data: {
                    product_data: {
                        name: 'Garbage',
                        description: 'Cubic Meters of Garbage'
                    },
                    currency: 'usd',
                    unit_amount: 10,
                },
                quantity: quantity,
            }
        ],
        mode: 'payment',
        success_url: 'http://localhost:8000/succes-payment',
        cancel_url: 'http://localhost:8000/cancel-payment'

    })
    return res.status(200).json(session)
})
payment.get('/succes-payment', (req, res) => res.status(200).json({ 'message': 'success-payment' }))
payment.get('/cancel-payment', (req, res) => res.status(404).json({ 'message': 'cancel-payment' }))

export default payment