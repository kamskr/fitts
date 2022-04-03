import * as admin from "firebase-admin";
import { EventContext } from "firebase-functions";
// eslint-disable-next-line import/no-unresolved
import { UserRecord } from "firebase-functions/v1/auth";

admin.initializeApp();

const db = admin.firestore();

/**
 * Creates a document with ID -> uid in the `Users` collection.
 *
 * @param {Object} userRecord Contains the auth, uid and displayName info.
 * @param {Object} context Details about the event.
 */
export const createProfile = (
  userRecord: UserRecord,
  context: EventContext
) => {
  const { email, phoneNumber, uid } = userRecord;

  return db
    .collection("users")
    .doc(email || uid)
    .set({ email, phoneNumber })
    .catch(console.error);
};
