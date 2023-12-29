package com.eminent.serverpush;

import com.eminent.util.IssueDetails;
import java.util.HashMap;
import javax.json.Json;
import javax.websocket.EncodeException;
import javax.websocket.Encoder;
import javax.websocket.EndpointConfig;

public class NotificationMessageEncoder implements Encoder.Text<NotificationMessage> {

    @Override
    public void init(final EndpointConfig config) {
    }

    @Override
    public void destroy() {
    }

    @Override
    public String encode(final NotificationMessage chatMessage) throws EncodeException {
        HashMap<String, String> hm = IssueDetails.getIssue(chatMessage.getIssueId());

        return Json.createObjectBuilder()
                .add("issueId", chatMessage.getIssueId())
                .add("assignedTo", chatMessage.getAssignedTo())
                .add("subject", hm.get("subject")).build()
                .toString();

    }
}
