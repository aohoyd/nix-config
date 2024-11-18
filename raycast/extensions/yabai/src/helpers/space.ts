import { runYabaiCommand } from "./scripts";

interface ISpace {
  id: number;
  uuid: string;
  index: number;
  label: string;
  type: string;
  display: number;
  windows: number[];
  "first-window": number;
  "last-window": number;
  "has-focus": boolean;
  "is-visible": boolean;
  "is-native-fullscreen": boolean;
}

export async function getSpace(): Promise<ISpace> {
  const space = await runYabaiCommand(`-m query --spaces --space`);
  if (space.stdout) {
    return JSON.parse(space.stdout);
  }
  throw new Error(space.stderr);
}
