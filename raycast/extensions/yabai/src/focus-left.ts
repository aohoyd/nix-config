import { showHUD } from "@raycast/api";
import { runYabaiCommand } from "./helpers/scripts";
import { getSpace } from "./helpers/space";
import { showFailureToast } from "@raycast/utils";

export default async function Command() {
  try {
    const space = await getSpace();
    const direction: string = space.type === "stack" ? "stack.next" : "east";

    const { stderr } = await runYabaiCommand(`-m window --focus ${direction}`);

    if (stderr) {
      throw new Error();
    }
  } catch (error) {
    if (error instanceof Error) {
      if (error.message.includes("Yabai executable not found")) {
        return;
      }
      if (error.message.includes("could not locate a westward managed window")) {
        return;
      }
      if (error.message.includes("could not locate the prev stacked window")) {
        showHUD("First stack window");
        return;
      }
    }

    showFailureToast(error, {
      title: "Failed to focus window, make sure you have Yabai installed and running.",
    });
  }
}
