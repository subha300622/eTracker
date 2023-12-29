package com.eminent.serverpush;

import com.eminent.util.IssueDetails;
import java.io.StringReader;
import java.util.HashMap;

import javax.json.Json;
import javax.json.JsonObject;
import javax.websocket.DecodeException;
import javax.websocket.Decoder;
import javax.websocket.EndpointConfig;

public class NotificationMessageDecoder implements Decoder.Text<NotificationMessage> {
	@Override
	public void init(final EndpointConfig config) {
	}

	@Override
	public void destroy() {
	}

	@Override
	public NotificationMessage decode(final String textMessage) throws DecodeException {
		NotificationMessage chatMessage = new NotificationMessage();
                
		JsonObject obj = Json.createReader(new StringReader(textMessage))
				.readObject();
		chatMessage.setIssueId(obj.getString("issueId"));
		chatMessage.setAssignedTo(obj.getString("assignedTo"));
                chatMessage.setSubject(obj.getString("subject"));
		return chatMessage;
	}

	@Override
	public boolean willDecode(final String s) {
		return true;
	}
}
