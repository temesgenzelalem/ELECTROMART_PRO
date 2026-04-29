---
name: Tech Pro Precision
colors:
  surface: '#031427'
  surface-dim: '#031427'
  surface-bright: '#2a3a4f'
  surface-container-lowest: '#000f21'
  surface-container-low: '#0b1c30'
  surface-container: '#102034'
  surface-container-high: '#1b2b3f'
  surface-container-highest: '#26364a'
  on-surface: '#d3e4fe'
  on-surface-variant: '#c6c6cd'
  inverse-surface: '#d3e4fe'
  inverse-on-surface: '#213145'
  outline: '#909097'
  outline-variant: '#45464d'
  surface-tint: '#bec6e0'
  primary: '#bec6e0'
  on-primary: '#283044'
  primary-container: '#0f172a'
  on-primary-container: '#798098'
  inverse-primary: '#565e74'
  secondary: '#adc6ff'
  on-secondary: '#002e6a'
  secondary-container: '#0566d9'
  on-secondary-container: '#e6ecff'
  tertiary: '#4cd7f6'
  on-tertiary: '#003640'
  tertiary-container: '#001b21'
  on-tertiary-container: '#008da5'
  error: '#ffb4ab'
  on-error: '#690005'
  error-container: '#93000a'
  on-error-container: '#ffdad6'
  primary-fixed: '#dae2fd'
  primary-fixed-dim: '#bec6e0'
  on-primary-fixed: '#131b2e'
  on-primary-fixed-variant: '#3f465c'
  secondary-fixed: '#d8e2ff'
  secondary-fixed-dim: '#adc6ff'
  on-secondary-fixed: '#001a42'
  on-secondary-fixed-variant: '#004395'
  tertiary-fixed: '#acedff'
  tertiary-fixed-dim: '#4cd7f6'
  on-tertiary-fixed: '#001f26'
  on-tertiary-fixed-variant: '#004e5c'
  background: '#031427'
  on-background: '#d3e4fe'
  surface-variant: '#26364a'
typography:
  h1:
    fontFamily: Inter
    fontSize: 48px
    fontWeight: '700'
    lineHeight: '1.1'
    letterSpacing: -0.02em
  h2:
    fontFamily: Inter
    fontSize: 30px
    fontWeight: '600'
    lineHeight: '1.2'
    letterSpacing: -0.01em
  h3:
    fontFamily: Inter
    fontSize: 24px
    fontWeight: '600'
    lineHeight: '1.3'
    letterSpacing: 0em
  body-lg:
    fontFamily: Inter
    fontSize: 18px
    fontWeight: '400'
    lineHeight: '1.6'
  body-md:
    fontFamily: Inter
    fontSize: 16px
    fontWeight: '400'
    lineHeight: '1.5'
  label-sm:
    fontFamily: Inter
    fontSize: 14px
    fontWeight: '500'
    lineHeight: '1.2'
    letterSpacing: 0.05em
  code:
    fontFamily: Space Grotesk
    fontSize: 14px
    fontWeight: '400'
    lineHeight: '1.4'
rounded:
  sm: 0.25rem
  DEFAULT: 0.5rem
  md: 0.75rem
  lg: 1rem
  xl: 1.5rem
  full: 9999px
spacing:
  unit: 4px
  xs: 0.5rem
  sm: 1rem
  md: 1.5rem
  lg: 2.5rem
  xl: 4rem
  gutter: 1.5rem
  container-max: 1440px
---

## Brand & Style

This design system is engineered for the high-stakes world of enterprise electronics procurement. The brand personality is authoritative, precise, and high-performance. It balances the reliability of traditional corporate structures with the cutting-edge innovation of the tech industry.

The design style is a hybrid of **Modern Corporate** and **Glassmorphism**. It utilizes a sophisticated layering system where critical data is presented on "glass" surfaces to suggest transparency and technical depth. The interface avoids unnecessary clutter, focusing instead on high information density that remains legible and organized. The emotional response is one of absolute trust—users should feel they are using a tool designed for professionals who value efficiency and hardware excellence.

## Colors

The palette is anchored by **Deep Midnight Blue (#0F172A)**, providing a stable, premium foundation particularly effective in Dark Mode. **Electric Blue (#3B82F6)** serves as the primary action color, driving user flow and identifying interactive states. **Vibrant Cyan (#06B6D4)** is used sparingly for technical highlights, such as data visualizations, active status indicators, and subtle glowing accents that reinforce the "high-tech" narrative.

In Light Mode, the Midnight Blue transitions to text and structural borders, while the background shifts to a clean, cool white (#F8FAFC). Dark Mode remains the "hero" state for this design system, emphasizing depth and luminous accents. Use subtle gradients that blend from the Primary to the Secondary color to indicate "energy" or "processing" states.

## Typography

The typography system relies on **Inter** for its exceptional legibility and systematic feel. A clear hierarchy is maintained through significant contrast in font weights and subtle shifts in letter spacing. 

Headlines use tight tracking and heavy weights to appear "engineered" and impactful. Body text is optimized for readability with generous line heights. For technical specifications and SKU numbers, a secondary monospace font style or **Space Grotesk** should be used to provide a "lab-tested" aesthetic. Use uppercase labels with increased letter spacing for categorization and navigation elements to ensure they are distinct from content.

## Layout & Spacing

The layout utilizes a **12-column fixed grid** for desktop, ensuring content remains centered and readable on ultra-wide professional monitors. On smaller viewports, the grid transitions to a fluid model. 

The spacing rhythm is based on a **4px baseline grid**. This mathematical precision ensures that all components align perfectly, reinforcing the theme of "professional grade" equipment. Gutters are kept at a consistent 24px (1.5rem) to provide enough "air" between technical components, preventing the UI from feeling cramped despite high information density. Internal padding within cards and containers should favor the "md" (1.5rem) unit to maintain a premium feel.

## Elevation & Depth

This design system uses a sophisticated layering approach. Depth is communicated through:

1.  **Backdrop Blurs:** High-level modals and navigation bars use a 20px blur with a 60% opacity fill of the background color, creating a "glassmorphism" effect that keeps the user grounded in their previous context.
2.  **Soft Ambient Shadows:** Shadows are diffused and tinted with the primary Midnight Blue color rather than pure black (e.g., `box-shadow: 0 10px 30px -10px rgba(15, 23, 42, 0.3)`).
3.  **Luminous Outlines:** Surfaces in Dark Mode use a 1px inner stroke with a slight gradient (Electric Blue to Transparent) on their top edge to simulate light hitting a physical edge.
4.  **Tonal Tiers:** The background uses the deepest shade (#0F172A), while cards and containers use a slightly lighter "Elevated" shade (#1E293B) to create a clear visual stack.

## Shapes

The shape language is defined by "The Golden Corner"—a **8px to 12px radius** that balances modern approachability with professional structure. 

-   **Standard Components:** Buttons, inputs, and small chips use an 8px radius.
-   **Large Containers:** Product cards and main content areas use a 12px radius.
-   **Interactive Indicators:** Small circular elements (radio buttons, status dots) provide a geometric contrast to the primarily rectangular layout.

Avoid fully pill-shaped buttons for primary actions; stay with the rounded-rect style to maintain the "Pro" engineering aesthetic.

## Components

-   **Buttons:** Primary buttons feature a subtle vertical gradient from #3B82F6 to #2563EB. Hover states should include a soft "glow" (outer shadow) in the same color.
-   **Input Fields:** Use a dark-filled background with a subtle 1px border. On focus, the border transitions to Electric Blue with a 2px outer glow.
-   **Cards:** Use the "Tonal Tiering" approach. Cards should have a subtle 1px border (#334155) and a very soft shadow. Product images within cards should be set against a neutral, high-contrast background.
-   **Chips/Tags:** Used for technical specs (e.g., "5G", "1TB SSD"). These should be low-contrast (Grey/Slate) until hovered, where they reveal a Cyan highlight.
-   **Status Indicators:** Use a pulse animation for "Live" or "Active" technical states, utilizing the Vibrant Cyan accent.
-   **Data Tables:** Essential for enterprise stores. These must feature "Zebra Striping" using subtle tonal shifts and a "sticky" header with a backdrop blur for persistent navigation during long scrolls.