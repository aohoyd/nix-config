import { showHUD } from "@raycast/api";
import { showFailureToast } from "@raycast/utils";
import { execaCommand } from "execa";
import { userInfo } from "os";
import { getYabaiServiceName } from "./helpers/scripts";

export default async function Command() {
  try {
    const yabaiServiceName: string = getYabaiServiceName();
    const uid = userInfo().uid;

    const { stderr } = await execaCommand(`/bin/launchctl kickstart -k gui/${uid}/${yabaiServiceName}`);

    if (stderr) {
      throw new Error(stderr);
    }

    showHUD("Restarted yabai service");
  } catch (error) {
    showFailureToast(error, {
      title: "Failed to start yabai service, make sure you have Yabai installed.",
    });
  }
}
