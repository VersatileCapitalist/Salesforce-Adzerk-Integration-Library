/**
 * Copyright (c) 2013, VersatileCapitalist Software, inc
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without modification, 
 *   are permitted provided that the following conditions are met:
 *
 * - Redistributions of source code must retain the above copyright notice, 
 *      this list of conditions and the following disclaimer.
 * - Redistributions in binary form must reproduce the above copyright notice, 
 *      this list of conditions and the following disclaimer in the documentation 
 *      and/or other materials provided with the distribution.
 * - Neither the name of the VersatileCapitalist Software, inc nor the names of its contributors 
 *      may be used to endorse or promote products derived from this software without 
 *      specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND 
 *  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES 
 *  OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL 
 *  THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, 
 *  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
 *  OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY
 *  OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 *  ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
**/ 

global with sharing class AdzerkZoneService  {
    
    global class Items {
    public Integer Id=0;
    public String Name;
    public Integer SiteId;

    public Items(){}
    public Items (JSONParser parser) {
     while (parser.nextToken() != JSONToken.END_OBJECT) {
                        if (parser.getCurrentToken() == JSONToken.FIELD_NAME) {
                                String text = parser.getText();
                                if (parser.nextToken() != JSONToken.VALUE_NULL) {
                                        if (text == 'Id'){
                                            Id=Integer.Valueof(parser.getText());
                                            } else if (text == 'Name') {
                                             Name= parser.getText();
                                             } else if (text == 'SiteId') {
                                                SiteId=Integer.Valueof(parser.getText());
                                                }
                                         }
                                   }
                            }
                }
  }
   
   public Integer PageNumber;
    public Integer PageSize;
    public Integer TotalPages;
    public Integer TotalItems;
    public List<Items> Items;   
    
    public AdzerkZoneService(){}
    public AdzerkZoneService  (JSONParser parser) {
     while (parser.nextToken() != JSONToken.END_OBJECT) {
                        if (parser.getCurrentToken() == JSONToken.FIELD_NAME) {
                                String text = parser.getText();
                                if (parser.nextToken() != JSONToken.VALUE_NULL) {
                                        if (text == 'PageNumber'){
                                            PageNumber= Integer.valueof(parser.getText());
                                            } else if (text == 'PageSize') {
                                             PageSize= Integer.valueof(parser.getText());
                                             } else if (text == 'TotalPages') {
                                              TotalPages= Integer.valueof(parser.getText());
                                             }else if (text == 'TotalItems') {
                                              TotalItems= Integer.valueof(parser.getText());
                                             }else if (text == 'Items') {
                                                Items = new List<Items>();
                                               while (parser.nextToken() != JSONToken.END_ARRAY) {
                                              Items .add(new Items(parser));
                                               }
                                             }
                                         }
                                 }
                       }
              }
    
      
     //Get Zone Data List from Adzerk          
     webService static AdzerkZoneService  GetZoneList(String accessApikey) {  
                String Apiendpoint= 'http://api.adzerk.net/v1/zone'; 
                Http h = new Http();
                HttpRequest req = new HttpRequest();
                req.setMethod('GET');
                req.setHeader('X-Adzerk-ApiKey',accessApikey);
                req.setHeader('Content-Type', 'application/x-www-form-urlencoded');                       
                req.setEndpoint(Apiendpoint);                         
                HttpResponse res=new HttpResponse();
                res = h.send(req);                              
                return new AdzerkZoneService(System.JSON.createParser(res.getbody()));
               
     }
     //Get Zone based on id from Adzerk          
     webService static AdzerkZoneService.Items GetZone(String accessApikey,Integer id) {   
                String Apiendpoint= 'http://api.adzerk.net/v1/zone';
                Http h = new Http();
                HttpRequest req = new HttpRequest();
                req.setMethod('GET');
                req.setHeader('X-Adzerk-ApiKey',accessApikey);
                req.setHeader('Content-Type', 'application/x-www-form-urlencoded');                       
                req.setEndpoint(Apiendpoint+'/'+id);                         
                HttpResponse res=new HttpResponse();
                res = h.send(req);              
                return new  AdzerkZoneService.Items(System.JSON.createParser(res.getbody()));
     }
      //Create Zone on Adzerk    
      webService static AdzerkZoneService.Items CreateZone (String accessApikey,AdzerkZoneService.Items zone) {
                String Apiendpoint= 'http://api.adzerk.net/v1/zone';
                string jsonContent= Json.Serialize(zone);                
                Http h = new Http();
                HttpRequest req = new HttpRequest();
                req.setMethod('POST');
                req.setHeader('X-Adzerk-ApiKey',accessApikey);
                req.setHeader('Content-Type', 'application/x-www-form-urlencoded');
                req.setBody('zone='+jsonContent);
                req.setEndpoint(Apiendpoint);                        
                HttpResponse res=new HttpResponse();
                res = h.send(req);
                return new AdzerkZoneService.Items(System.JSON.createParser(res.getbody()));
      }
     //Update Zone on Adzerk    
     webService static AdzerkZoneService.Items  UpdateZone(String accessApikey,Integer id,AdzerkZoneService.Items zone) {
                String Apiendpoint= 'http://api.adzerk.net/v1/zone';
                string jsonContent= Json.Serialize(zone);                            
                Http h = new Http();
                HttpRequest req = new HttpRequest();
                req.setMethod('PUT');
                req.setHeader('X-Adzerk-ApiKey',accessApikey);
                req.setHeader('Content-Type', 'application/x-www-form-urlencoded');
                req.setBody('zone='+jsonContent);
                req.setEndpoint(Apiendpoint+'/'+id);                        
                HttpResponse res=new HttpResponse();
                res = h.send(req);
                return new AdzerkZoneService.Items(System.JSON.createParser(res.getbody()));
     } 
    
   
}