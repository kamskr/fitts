import * as functions from "firebase-functions";
import { createProfile } from "./users";

module.exports = {
  authOnCreate: functions.auth.user().onCreate(createProfile),
};
