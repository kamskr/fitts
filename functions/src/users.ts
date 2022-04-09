import * as admin from "firebase-admin";
import { EventContext } from "firebase-functions";
// eslint-disable-next-line import/no-unresolved
import { UserRecord } from "firebase-functions/v1/auth";

admin.initializeApp();

const db = admin.firestore();

/**
 * Creates a document with ID -> uid in the `UserProfiles` collection.
 *
 * @param {Object} userRecord Contains the auth, uid and displayName info.
 * @param {Object} context Details about the event.
 */
export const createProfile = (userRecord: UserRecord, _: EventContext) => {
  const { email, uid, displayName, photoURL } = userRecord;

  return db
    .collection("UserProfiles")
    .doc(email || uid)
    .set({
      email,
      displayName,
      photoURL,
    })
    .catch(console.error);
};
