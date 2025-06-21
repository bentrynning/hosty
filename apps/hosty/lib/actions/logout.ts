"use server";

import { redirect } from "next/navigation";
import { deleteSession } from "../auth";
import { cookies } from "next/headers";

export async function handleLogout() {
  const cookie = await cookies();

  try {
    const sessionId = cookie.get("session")?.value;

    if (sessionId) {
      await deleteSession(sessionId);
    }

    // Clear session cookie
    cookie.delete("session");

    redirect("/login");
  } catch (error) {
    console.error("Logout error:", error);
  }
}
