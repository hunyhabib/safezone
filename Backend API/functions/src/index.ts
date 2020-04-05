import * as functions from "firebase-functions";
import * as admin from "firebase-admin";


const db = admin.initializeApp().firestore();

export const addDate = functions.https.onRequest(
    async (req, res) => {
        const input = req.body;
        //input.From = new Date(input.From).getTime();
        //input.To = new Date(input.To).getTime();
        await db.collection('data').add({ ...input });
        res.status(201).send();
    });

export const getData = functions.https.onRequest(
    async (req, res) => {
        const placeId = req.query.PlaceId;
        const query = await db.collection("data")
            .where("PlaceId", "==", placeId)
            .where("From", ">=", new Date().getTime())
            .get();
        const result = query.docs.map(doc => {
            const data = doc.data();
            return {
                id: doc.id,
                From: new Date(data.From),
                To: new Date(data.To)
            }
        });
        res.status(200).send(result);
    });

export const getCount = functions.https.onRequest(
    async (req, res) => {
        const input = req.body;
        //const From = new Date(input.From).getTime();
        //const To = new Date(input.To).getTime();
        const query = await db.collection("data")
            .where("PlaceId", "==", input.PlaceId)
            .where("From", ">=", input.From)
            .get();
        let count = 0;
        query.docs.map(doc => {
            if (doc.data().To <= input.To)
                count++;
        });
        res.status(200).send(count.toString());
    });