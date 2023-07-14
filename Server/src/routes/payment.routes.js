import express, { Router } from 'express';
import Stripe from 'stripe';
import dotenv from 'dotenv';
import { login, createInvoice } from 'qvapay-sdk';
import { Tropipay, TropipayConfig } from '@yosle/tropipayjs'
const axios = require('axios').default;

dotenv.config()

const payment = Router()

payment.use(express.json())
const stripe = new Stripe(process.env.APIKEY)

const obtainDate = () => {
    const fechaActual = new Date();
    const anio = fechaActual.getFullYear();
    const mes = fechaActual.getMonth() + 1; // Los meses en JavaScript empiezan en 0, por lo que se agrega 1
    const dia = fechaActual.getDate();

    // Agrega un cero inicial a los meses y días menores a 10
    const mesConCero = mes < 10 ? "0" + mes : mes;
    const diaConCero = dia < 10 ? "0" + dia : dia;

    // Concatena las partes de la fecha en una cadena con el formato deseado
    return `${anio}-${mesConCero}-${diaConCero}`;
}

payment.post('/api/v1/create-checkout', async (req, res) => {
    const { quantity } = req.body;
    if (!quantity) return res.status(404).json({
        "message": {
            "error": "Faltan Datos"
        }
    })
    if (typeof quantity !== 'number') return res.status(404).json({
        "message": {
            "error": "El valor no es un numero"
        }
    })
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

payment.post('/api/v1/create-qvapay-checkout', async (req, res) => {
    const { quantity } = req.body;
    if (!quantity) return res.status(404).json({
        "message": {
            "error": "Faltan Datos"
        }
    })
    if (typeof quantity !== 'number') return res.status(404).json({
        "message": {
            "error": "El valor no es un numero"
        }
    })

    const appAuth = {
        app_id: process.env.APP_ID,
        app_secret: process.env.APP_SECRET,
    };
    const invoice = {
        ...appAuth,
        amount: quantity * 0.10,
        description: 'Amount of Garbage',
        remote_id: 'Garbage',
        signed: 1,
    };
    const session = await createInvoice(invoice);
    return res.status(200).json(session)
})


payment.post('/api/v1/create-tropipay-checkout', async (req, res) => {
    const { quantity } = req.body;
    if (!quantity) return res.status(404).json({
        "message": {
            "error": "Faltan Datos"
        }
    })
    if (typeof quantity !== 'number') return res.status(404).json({
        "message": {
            "error": "El valor no es un numero"
        }
    })
    try {
        const config = {
            clientId: process.env.TROPIPAY_CLIENT_ID,
            clientSecret: process.env.TROPIPAY_CLIENT_SECRET,
            serverMode: 'Development' // For production serverMode: 'Production'
        }
        const tpp = new Tropipay(config)
        const payload = {
            reference: "garbage collection",
            concept: "Garbage",
            favorite: "true",
            amount: quantity * 100,
            currency: "USD",
            description: "Garbage collection",
            singleUse: "true",
            reasonId: 4,
            expirationDays: 1,
            lang: "es",
            urlSuccess: 'http://127.0.0.1:8000/succes-payment',
            urlFailed: 'http://127.0.0.1:8000/cancel-payment',
            urlNotification: 'http://127.0.0.1:8000/succes-payment',
            serviceDate: obtainDate(),
            directPayment: "true",
            paymentMethods: [
                "EXT",
                "TPP"
            ]
        }
        const paylink = await tpp.createPaymentCard(payload);

        res.status(200).json(paylink)
    } catch (error) {
        console.log(error)
        res.status(400).json({
            "message": {
                "error": error
            }
        })
    }

})

payment.get('/api/v1/succes-payment', (req, res) => res.status(200).json({ 'message': 'success-payment' }))
payment.get('/api/v1/cancel-payment', (req, res) => res.status(404).json({ 'message': 'cancel-payment' }))

export default payment