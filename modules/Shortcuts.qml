import qs.widgets
import qs.services
import Quickshell
import Quickshell.Io

Scope {
    id: root

    CustomShortcut {
        name: "showall"
        description: "Toggle dashboard, osd, and utilities"
        onPressed: {
            const v = Visibilities.getForActive();
            v.dashboard = v.osd = v.utilities = !(v.dashboard || v.osd || v.utilities);
        }
    }

    CustomShortcut {
        name: "session"
        description: "Toggle session menu"
        onPressed: {
            const visibilities = Visibilities.getForActive();
            visibilities.session = !visibilities.session;
        }
    }

    IpcHandler {
        target: "drawers"

        function toggle(drawer: string): void {
            if (list().split("\n").includes(drawer)) {
                const visibilities = Visibilities.getForActive();
                visibilities[drawer] = !visibilities[drawer];
            } else {
                console.warn(`[IPC] Drawer "${drawer}" does not exist`);
            }
        }

        function list(): string {
            const visibilities = Visibilities.getForActive();
            return Object.keys(visibilities).filter(k => typeof visibilities[k] === "boolean").join("\n");
        }
    }
}
