---
name: mobile-mcp
description: Mobile device automation using Mobile MCP server for iOS and Android. This skill should be used when interacting with mobile apps on simulators, emulators, or physical devices - tapping, swiping, typing, taking screenshots, launching apps, or automating mobile workflows. Triggers on "tap on mobile", "mobile screenshot", "launch app", "swipe", "mobile automation", "test on device", "iOS simulator", "Android emulator".
---

# mobile-mcp: Mobile Device Automation

Mobile MCP is an MCP server that enables automation of iOS and Android applications across simulators, emulators, and physical devices. It uses native accessibility trees for element discovery and coordinate-based interactions.

## Setup Check

Before using mobile-mcp tools, verify the MCP server is configured. The tools should be available as `mcp__mobile-mcp__mobile_*` functions.

If tools are not available, add to Claude Code MCP config:

```json
{
  "mcpServers": {
    "mobile-mcp": {
      "command": "npx",
      "args": ["-y", "@mobilenext/mobile-mcp@latest"]
    }
  }
}
```

### Prerequisites

- **iOS**: Xcode command line tools + Simulator running
- **Android**: Android Platform Tools + emulator running
- **Node.js**: v22+

## Core Workflow

**The screenshot + element list pattern is optimal for mobile automation:**

1. **List devices** to find target device identifier
2. **Launch app** or **open URL** on device
3. **List elements** to discover interactive UI components with coordinates
4. **Interact** using coordinates (tap, type, swipe)
5. **Take screenshot** to verify state after interaction
6. **Repeat** steps 3-5 as needed

```
list_available_devices → launch_app → list_elements_on_screen → interact → take_screenshot → repeat
```

## Tools Reference

### Device Management

| Tool | Parameters | Description |
|------|-----------|-------------|
| `mobile_list_available_devices` | none | List all physical devices, simulators, and emulators |
| `mobile_get_screen_size` | `device` | Get device screen dimensions in pixels |
| `mobile_get_orientation` | `device` | Check portrait/landscape orientation |
| `mobile_set_orientation` | `device`, `orientation` (portrait/landscape) | Rotate screen |

### App Management

| Tool | Parameters | Description |
|------|-----------|-------------|
| `mobile_list_apps` | `device` | List all installed applications |
| `mobile_launch_app` | `device`, `packageName` | Open app by bundle/package ID |
| `mobile_terminate_app` | `device`, `packageName` | Close running app |
| `mobile_install_app` | `device`, `path` (.apk/.ipa/.app/.zip) | Install app from file |
| `mobile_uninstall_app` | `device`, `bundle_id` | Remove app from device |

### Screen Interaction

| Tool | Parameters | Description |
|------|-----------|-------------|
| `mobile_list_elements_on_screen` | `device` | List UI elements with coordinates and labels |
| `mobile_click_on_screen_at_coordinates` | `device`, `x`, `y` | Tap at coordinates |
| `mobile_double_tap_on_screen` | `device`, `x`, `y` | Double-tap at coordinates |
| `mobile_long_press_on_screen_at_coordinates` | `device`, `x`, `y`, `duration?` (ms, default 500) | Long press |
| `mobile_swipe_on_screen` | `device`, `direction` (up/down/left/right), `x?`, `y?`, `distance?` | Swipe gesture |

### Text Input & Navigation

| Tool | Parameters | Description |
|------|-----------|-------------|
| `mobile_type_keys` | `device`, `text`, `submit` (boolean) | Type text into focused element |
| `mobile_press_button` | `device`, `button` (HOME/BACK/VOLUME_UP/VOLUME_DOWN/ENTER) | Press device button |
| `mobile_open_url` | `device`, `url` | Open URL in device browser |

### Screenshots

| Tool | Parameters | Description |
|------|-----------|-------------|
| `mobile_take_screenshot` | `device` | Capture screen (returns base64 image) |
| `mobile_save_screenshot` | `device`, `saveTo` (file path) | Save screenshot to file |

## Key Patterns

### Finding the Device Identifier

Always start by listing devices. The `device` parameter is required for nearly every tool.

```
1. Call mobile_list_available_devices
2. Pick the target device identifier from the list
3. Use that identifier for all subsequent calls
```

### Element Discovery via Accessibility Tree

`mobile_list_elements_on_screen` returns UI elements with:
- Display text or accessibility label
- Screen coordinates (x, y)

Use these coordinates for tap/click interactions. This is more reliable than guessing coordinates from screenshots.

### Screenshot + Elements Combo

For complex interactions, combine element listing with screenshots:
1. `mobile_list_elements_on_screen` — get structured element data
2. `mobile_take_screenshot` — visual context for layout understanding
3. Use element coordinates from step 1 for precise interactions

### Scrolling to Find Elements

If the target element is not visible in `mobile_list_elements_on_screen`:
1. `mobile_swipe_on_screen` with direction "up" to scroll down
2. `mobile_list_elements_on_screen` again to check for the element
3. Repeat until found

## Examples

### Launch App and Take Screenshot

```
mobile_list_available_devices
  → device: "iPhone 16 Pro"

mobile_launch_app
  device: "iPhone 16 Pro"
  packageName: "com.example.myapp"

mobile_take_screenshot
  device: "iPhone 16 Pro"
  → base64 image of app screen
```

### Fill a Login Form

```
mobile_list_elements_on_screen
  device: "iPhone 16 Pro"
  → textfield "Email" at (200, 350)
  → textfield "Password" at (200, 420)
  → button "Sign In" at (200, 500)

mobile_click_on_screen_at_coordinates
  device: "iPhone 16 Pro", x: 200, y: 350

mobile_type_keys
  device: "iPhone 16 Pro", text: "user@example.com", submit: false

mobile_click_on_screen_at_coordinates
  device: "iPhone 16 Pro", x: 200, y: 420

mobile_type_keys
  device: "iPhone 16 Pro", text: "password123", submit: false

mobile_click_on_screen_at_coordinates
  device: "iPhone 16 Pro", x: 200, y: 500

mobile_take_screenshot
  device: "iPhone 16 Pro"
  → verify logged in
```

### Navigate and Scroll

```
mobile_launch_app
  device: "Pixel 8", packageName: "com.android.settings"

mobile_swipe_on_screen
  device: "Pixel 8", direction: "up"

mobile_list_elements_on_screen
  device: "Pixel 8"
  → find target element coordinates

mobile_click_on_screen_at_coordinates
  device: "Pixel 8", x: 540, y: 680
```

### Android Back Navigation

```
mobile_press_button
  device: "Pixel 8", button: "BACK"
```

## vs Playwright MCP (Browser)

| Feature | mobile-mcp | Playwright MCP |
|---------|-----------|----------------|
| Target | Mobile apps (iOS/Android) | Web browsers |
| Selection | Coordinates from accessibility tree | Refs from DOM snapshot |
| Gestures | Swipe, long press, double tap | Click, hover, drag |
| Navigation | App launch, device buttons | URL navigation, tabs |
| Best for | Native mobile app automation | Web page automation |

Use mobile-mcp for native mobile app testing and automation. Use Playwright MCP for web browser automation.
