package apm.websocket.system;

import javax.websocket.EncodeException;
import javax.websocket.Encoder;
import javax.websocket.EndpointConfig;

import net.sf.json.JSONArray;
import apm.entity.system.NetEntity;

public class NetEncoder implements Encoder.Text<NetEntity> {

	@Override
	public void destroy() {

	}

	@Override
	public void init(EndpointConfig arg0) {

	}

	@Override
	public String encode(NetEntity object) throws EncodeException {
		JSONArray jsonarray = JSONArray.fromObject(object);
		return jsonarray.toString();
	}

}
