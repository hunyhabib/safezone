import * as functions from "firebase-functions";
import * as admin from "firebase-admin";


const db = admin.initializeApp().firestore();

export const addDate = functions.https.onRequest(
    async (req, res) => {
        const input = req.body;
        input.From = new Date(input.From).getTime();
        input.To = new Date(input.To).getTime();
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
            const res = doc.data();
            return {
                id: doc.id,
                From: new Date(res.From),
                To: new Date(res.To)
            }
        });
        res.status(200).send(result);
    });