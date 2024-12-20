import { showHUD } from "@raycast/api";
import { runYabaiCommand } from "./helpers/scripts";
import { showFailureToast } from "@raycast/utils";

export default async function Command() {
  try {
    const { stderr } = await runYabaiCommand("-m space --layout bsp");

    if (stderr) {
      throw new Error();
    }

    const { stderr: swapStderr } = await runYabaiCommand("-m window --swap first");

    if (swapStderr) {
      throw new Error();
    }

    showHUD("Switched to BSP layout");
  } catch (error) {
    if (error instanceof Error && error.message.includes("Yabai executable not found")) {
      return;
    }

    showFailureToast(error, {
      title: "Failed to switch to BSP layout, make sure you have Yabai installed and running.",
    });
  }
}
