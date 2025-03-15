// Test script with different video ID
const { YoutubeTranscript } = require("youtube-transcript");
const VIDEO_ID = "jNQXAC9IVRw"; // First YouTube video
async function main() { try { console.log(`Fetching transcript for ${VIDEO_ID}`); const transcript = await YoutubeTranscript.fetchTranscript(VIDEO_ID); console.log(JSON.stringify(transcript.slice(0, 3), null, 2)); console.log(`Total entries: ${transcript.length}`); } catch (error) { console.error(error.message); } } main();
