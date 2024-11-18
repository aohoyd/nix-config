import { runYabaiCommand } from "./helpers/scripts";
import { showFailureToast } from "@raycast/utils";

export default async function Command() {
  try {
    const { stderr } = await runYabaiCommand("-m window --focus north");

    if (stderr) {
      throw new Error();
    }
  } catch (error) {
    if (error instanceof Error) {
      if (error.message.includes("Yabai executable not found")) {
        return;
      }
      if (error.message.includes("could not locate a northward managed window")) {
        return;
      }
    }

    showFailureToast(error, {
      title: "Failed to focus window, make sure you have Yabai installed and running.",
    });
  }
}
