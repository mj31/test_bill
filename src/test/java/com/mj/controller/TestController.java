package com.mj.controller;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import com.mj.bill.controller.BankController;

@RunWith(SpringJUnit4ClassRunner.class)		//表示继承了SpringJUnit4ClassRunner类
@WebAppConfiguration()
@ContextConfiguration(locations = {"classpath:spring/spring-mybatis.xml"})
public class TestController {
	    @Autowired
	    protected WebApplicationContext wac;

	    @Autowired
	    private BankController bankController;

	    private MockMvc mockMvc;

	    @Before
	    public void setUp() throws Exception {
	        mockMvc = MockMvcBuilders.standaloneSetup(bankController).build();
	    }


	    @Test
	    public void test_bankSearch () {
	        try {
	        	String content =   mockMvc.perform(MockMvcRequestBuilders
	                    .post("/bank/search")
	                    .accept(MediaType.APPLICATION_JSON)
	                    .param("serialNumber", "1234")
	            ).andReturn().getResponse().getContentAsString();
	            
	           System.out.println(content); 
	                 /*   .andDo(print());*/

	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	    }
}
