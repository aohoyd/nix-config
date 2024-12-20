import { showHUD } from "@raycast/api";
import { runYabaiCommand } from "./helpers/scripts";
import { showFailureToast } from "@raycast/utils";

export default async function Command() {
  try {
    const { stderr } = await runYabaiCommand("-m window --toggle float --grid 4:4:1:1:2:2");

    if (stderr) {
      throw new Error();
    }

    showHUD("Toggled float window");
  } catch (error) {
    if (error instanceof Error && error.message.includes("Yabai executable not found")) {
      return;
    }

    showFailureToast(error, {
      title: "Failed to toggle float window, make sure you have Yabai installed and running.",
    });
  }
}
