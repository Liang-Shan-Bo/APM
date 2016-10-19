package apm.websocket.system;

import java.util.List;

import javax.websocket.EncodeException;
import javax.websocket.Encoder;
import javax.websocket.EndpointConfig;

import net.sf.json.JSONArray;
import apm.entity.system.ProEntity;

public class ProEncoder implements Encoder.Text<List<ProEntity>> {

	@Override
	public void destroy() {

	}

	@Override
	public void init(EndpointConfig arg0) {

	}

	@Override
	public String encode(List<ProEntity> object) throws EncodeException {
		JSONArray jsonarray = JSONArray.fromObject(object);
		return jsonarray.toString();
	}

}
