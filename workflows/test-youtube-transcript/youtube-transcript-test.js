// Test script for youtube-transcript package
const { YoutubeTranscript } = require('youtube-transcript');

// Test video ID (a TED talk)
const VIDEO_ID = 'JabvZPDLX9c';

async function main() {
	try {
		console.log(`Fetching transcript for video ID: ${VIDEO_ID}`);
		const transcript = await YoutubeTranscript.fetchTranscript(VIDEO_ID);
		console.log('Transcript successfully fetched:');
		console.log(JSON.stringify(transcript.slice(0, 5), null, 2)); // Show the first 5 entries
		console.log(`Total transcript entries: ${transcript.length}`);
	} catch (error) {
		console.error('Error fetching transcript:', error.message);
	}
}

main();
