package apm.websocket.service;

import javax.websocket.EncodeException;
import javax.websocket.Encoder;
import javax.websocket.EndpointConfig;

import net.sf.json.JSONArray;
import apm.entity.service.ServiceEntity;

public class ServiceEncoder implements Encoder.Text<ServiceEntity> {

	@Override
	public void destroy() {

	}

	@Override
	public void init(EndpointConfig arg0) {

	}

	@Override
	public String encode(ServiceEntity serviceEntity) throws EncodeException {
		JSONArray jsonarray = JSONArray.fromObject(serviceEntity);
		return jsonarray.toString();
	}

}
