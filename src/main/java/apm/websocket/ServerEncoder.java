package apm.websocket;

import java.util.LinkedList;

import javax.websocket.EncodeException;
import javax.websocket.Encoder;
import javax.websocket.EndpointConfig;

import net.sf.json.JSONArray;
import apm.entity.SystemInfo;

public class ServerEncoder implements Encoder.Text<LinkedList<SystemInfo>> {

	@Override
	public void destroy() {

	}

	@Override
	public void init(EndpointConfig arg0) {

	}

	@Override
	public String encode(LinkedList<SystemInfo> linkedList) throws EncodeException {
		JSONArray jsonarray = JSONArray.fromObject(linkedList);  
		return jsonarray.toString();
	}

}
