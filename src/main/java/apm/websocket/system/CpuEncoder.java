package apm.websocket.system;

import java.util.List;

import javax.websocket.EncodeException;
import javax.websocket.Encoder;
import javax.websocket.EndpointConfig;

import net.sf.json.JSONArray;
import apm.entity.system.CpuEntity;

public class CpuEncoder implements Encoder.Text<List<CpuEntity>> {

	@Override
	public void destroy() {

	}

	@Override
	public void init(EndpointConfig arg0) {

	}

	@Override
	public String encode(List<CpuEntity> object) throws EncodeException {
		JSONArray jsonarray = JSONArray.fromObject(object);
		return jsonarray.toString();
	}

}
