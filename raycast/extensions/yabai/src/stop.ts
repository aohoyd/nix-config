import { showHUD } from "@raycast/api";
import { getYabaiServiceName } from "./helpers/scripts";
import { showFailureToast } from "@raycast/utils";
import { execaCommand } from "execa";

export default async function Command() {
  try {
    const yabaiServiceName: string = getYabaiServiceName();
    const { stderr } = await execaCommand(`/bin/launchctl stop ${yabaiServiceName}`);

    if (stderr) {
      throw new Error();
    }

    showHUD("Stopped yabai service");
  } catch (error) {
    if (error instanceof Error && error.message.includes("Yabai executable not found")) {
      return;
    }

    showFailureToast(error, {
      title: "Failed to stop yabai service, make sure you have Yabai installed and running.",
    });
  }
}
