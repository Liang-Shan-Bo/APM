package apm.websocket;

import java.util.concurrent.CopyOnWriteArrayList;

import javax.websocket.EncodeException;
import javax.websocket.Encoder;
import javax.websocket.EndpointConfig;

import net.sf.json.JSONArray;
import apm.entity.SystemInfo;

public class SystemEncoder implements Encoder.Text<CopyOnWriteArrayList<SystemInfo>> {

	@Override
	public void destroy() {

	}

	@Override
	public void init(EndpointConfig arg0) {

	}

	@Override
	public String encode(CopyOnWriteArrayList<SystemInfo> linkedList) throws EncodeException {
		JSONArray jsonarray = JSONArray.fromObject(linkedList);  
		return jsonarray.toString();
	}

}
