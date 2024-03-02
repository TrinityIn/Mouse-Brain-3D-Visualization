import { Inter } from "next/font/google";
import { Bebas_Neue } from "next/font/google";
import "./globals.css";

const bebas = Bebas_Neue({weight: "400", subsets: ["latin"]})
const inter = Inter({ subsets: ["latin"] });

export const metadata = {
  title: "Brain Voyager 🧠",
  description: "NeuroHackathon 2024 Project",
};

export default function RootLayout({ children }) {
  return (
    <html lang="en">
      
      <body className={bebas.className}>{children}</body>
    </html>
  );
}
