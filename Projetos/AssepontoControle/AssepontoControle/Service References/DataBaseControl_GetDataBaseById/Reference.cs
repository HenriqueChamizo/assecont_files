﻿//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated by a tool.
//     Runtime Version:4.0.30319.42000
//
//     Changes to this file may cause incorrect behavior and will be lost if
//     the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace Asseponto.DataBaseControl_GetDataBaseById {
    
    
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.ServiceModel", "4.0.0.0")]
    [System.ServiceModel.ServiceContractAttribute(ConfigurationName="DataBaseControl_GetDataBaseById.DatabasesSoap")]
    public interface DatabasesSoap {
        
        // CODEGEN: Generating message contract since element name cnpj from namespace http://tempuri.org/ is not marked nillable
        [System.ServiceModel.OperationContractAttribute(Action="http://tempuri.org/getEmpresaDadosCnpj", ReplyAction="*")]
        Asseponto.DataBaseControl_GetDataBaseById.getEmpresaDadosCnpjResponse getEmpresaDadosCnpj(Asseponto.DataBaseControl_GetDataBaseById.getEmpresaDadosCnpjRequest request);
        
        // CODEGEN: Generating message contract since element name email from namespace http://tempuri.org/ is not marked nillable
        [System.ServiceModel.OperationContractAttribute(Action="http://tempuri.org/getEmpresaDadosEmail", ReplyAction="*")]
        Asseponto.DataBaseControl_GetDataBaseById.getEmpresaDadosEmailResponse getEmpresaDadosEmail(Asseponto.DataBaseControl_GetDataBaseById.getEmpresaDadosEmailRequest request);
        
        // CODEGEN: Generating message contract since element name getEmpresaDadosDatabaseResult from namespace http://tempuri.org/ is not marked nillable
        [System.ServiceModel.OperationContractAttribute(Action="http://tempuri.org/getEmpresaDadosDatabase", ReplyAction="*")]
        Asseponto.DataBaseControl_GetDataBaseById.getEmpresaDadosDatabaseResponse getEmpresaDadosDatabase(Asseponto.DataBaseControl_GetDataBaseById.getEmpresaDadosDatabaseRequest request);
        
        // CODEGEN: Generating message contract since element name getDatabasesResult from namespace http://tempuri.org/ is not marked nillable
        [System.ServiceModel.OperationContractAttribute(Action="http://tempuri.org/getDatabases", ReplyAction="*")]
        Asseponto.DataBaseControl_GetDataBaseById.getDatabasesResponse getDatabases(Asseponto.DataBaseControl_GetDataBaseById.getDatabasesRequest request);
    }
    
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.ServiceModel", "4.0.0.0")]
    [System.ComponentModel.EditorBrowsableAttribute(System.ComponentModel.EditorBrowsableState.Advanced)]
    [System.ServiceModel.MessageContractAttribute(IsWrapped=false)]
    public partial class getEmpresaDadosCnpjRequest {
        
        [System.ServiceModel.MessageBodyMemberAttribute(Name="getEmpresaDadosCnpj", Namespace="http://tempuri.org/", Order=0)]
        public Asseponto.DataBaseControl_GetDataBaseById.getEmpresaDadosCnpjRequestBody Body;
        
        public getEmpresaDadosCnpjRequest() {
        }
        
        public getEmpresaDadosCnpjRequest(Asseponto.DataBaseControl_GetDataBaseById.getEmpresaDadosCnpjRequestBody Body) {
            this.Body = Body;
        }
    }
    
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.ServiceModel", "4.0.0.0")]
    [System.ComponentModel.EditorBrowsableAttribute(System.ComponentModel.EditorBrowsableState.Advanced)]
    [System.Runtime.Serialization.DataContractAttribute(Namespace="http://tempuri.org/")]
    public partial class getEmpresaDadosCnpjRequestBody {
        
        [System.Runtime.Serialization.DataMemberAttribute(EmitDefaultValue=false, Order=0)]
        public string cnpj;
        
        public getEmpresaDadosCnpjRequestBody() {
        }
        
        public getEmpresaDadosCnpjRequestBody(string cnpj) {
            this.cnpj = cnpj;
        }
    }
    
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.ServiceModel", "4.0.0.0")]
    [System.ComponentModel.EditorBrowsableAttribute(System.ComponentModel.EditorBrowsableState.Advanced)]
    [System.ServiceModel.MessageContractAttribute(IsWrapped=false)]
    public partial class getEmpresaDadosCnpjResponse {
        
        [System.ServiceModel.MessageBodyMemberAttribute(Name="getEmpresaDadosCnpjResponse", Namespace="http://tempuri.org/", Order=0)]
        public Asseponto.DataBaseControl_GetDataBaseById.getEmpresaDadosCnpjResponseBody Body;
        
        public getEmpresaDadosCnpjResponse() {
        }
        
        public getEmpresaDadosCnpjResponse(Asseponto.DataBaseControl_GetDataBaseById.getEmpresaDadosCnpjResponseBody Body) {
            this.Body = Body;
        }
    }
    
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.ServiceModel", "4.0.0.0")]
    [System.ComponentModel.EditorBrowsableAttribute(System.ComponentModel.EditorBrowsableState.Advanced)]
    [System.Runtime.Serialization.DataContractAttribute(Namespace="http://tempuri.org/")]
    public partial class getEmpresaDadosCnpjResponseBody {
        
        [System.Runtime.Serialization.DataMemberAttribute(EmitDefaultValue=false, Order=0)]
        public string getEmpresaDadosCnpjResult;
        
        public getEmpresaDadosCnpjResponseBody() {
        }
        
        public getEmpresaDadosCnpjResponseBody(string getEmpresaDadosCnpjResult) {
            this.getEmpresaDadosCnpjResult = getEmpresaDadosCnpjResult;
        }
    }
    
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.ServiceModel", "4.0.0.0")]
    [System.ComponentModel.EditorBrowsableAttribute(System.ComponentModel.EditorBrowsableState.Advanced)]
    [System.ServiceModel.MessageContractAttribute(IsWrapped=false)]
    public partial class getEmpresaDadosEmailRequest {
        
        [System.ServiceModel.MessageBodyMemberAttribute(Name="getEmpresaDadosEmail", Namespace="http://tempuri.org/", Order=0)]
        public Asseponto.DataBaseControl_GetDataBaseById.getEmpresaDadosEmailRequestBody Body;
        
        public getEmpresaDadosEmailRequest() {
        }
        
        public getEmpresaDadosEmailRequest(Asseponto.DataBaseControl_GetDataBaseById.getEmpresaDadosEmailRequestBody Body) {
            this.Body = Body;
        }
    }
    
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.ServiceModel", "4.0.0.0")]
    [System.ComponentModel.EditorBrowsableAttribute(System.ComponentModel.EditorBrowsableState.Advanced)]
    [System.Runtime.Serialization.DataContractAttribute(Namespace="http://tempuri.org/")]
    public partial class getEmpresaDadosEmailRequestBody {
        
        [System.Runtime.Serialization.DataMemberAttribute(EmitDefaultValue=false, Order=0)]
        public string email;
        
        public getEmpresaDadosEmailRequestBody() {
        }
        
        public getEmpresaDadosEmailRequestBody(string email) {
            this.email = email;
        }
    }
    
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.ServiceModel", "4.0.0.0")]
    [System.ComponentModel.EditorBrowsableAttribute(System.ComponentModel.EditorBrowsableState.Advanced)]
    [System.ServiceModel.MessageContractAttribute(IsWrapped=false)]
    public partial class getEmpresaDadosEmailResponse {
        
        [System.ServiceModel.MessageBodyMemberAttribute(Name="getEmpresaDadosEmailResponse", Namespace="http://tempuri.org/", Order=0)]
        public Asseponto.DataBaseControl_GetDataBaseById.getEmpresaDadosEmailResponseBody Body;
        
        public getEmpresaDadosEmailResponse() {
        }
        
        public getEmpresaDadosEmailResponse(Asseponto.DataBaseControl_GetDataBaseById.getEmpresaDadosEmailResponseBody Body) {
            this.Body = Body;
        }
    }
    
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.ServiceModel", "4.0.0.0")]
    [System.ComponentModel.EditorBrowsableAttribute(System.ComponentModel.EditorBrowsableState.Advanced)]
    [System.Runtime.Serialization.DataContractAttribute(Namespace="http://tempuri.org/")]
    public partial class getEmpresaDadosEmailResponseBody {
        
        [System.Runtime.Serialization.DataMemberAttribute(EmitDefaultValue=false, Order=0)]
        public string getEmpresaDadosEmailResult;
        
        public getEmpresaDadosEmailResponseBody() {
        }
        
        public getEmpresaDadosEmailResponseBody(string getEmpresaDadosEmailResult) {
            this.getEmpresaDadosEmailResult = getEmpresaDadosEmailResult;
        }
    }
    
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.ServiceModel", "4.0.0.0")]
    [System.ComponentModel.EditorBrowsableAttribute(System.ComponentModel.EditorBrowsableState.Advanced)]
    [System.ServiceModel.MessageContractAttribute(IsWrapped=false)]
    public partial class getEmpresaDadosDatabaseRequest {
        
        [System.ServiceModel.MessageBodyMemberAttribute(Name="getEmpresaDadosDatabase", Namespace="http://tempuri.org/", Order=0)]
        public Asseponto.DataBaseControl_GetDataBaseById.getEmpresaDadosDatabaseRequestBody Body;
        
        public getEmpresaDadosDatabaseRequest() {
        }
        
        public getEmpresaDadosDatabaseRequest(Asseponto.DataBaseControl_GetDataBaseById.getEmpresaDadosDatabaseRequestBody Body) {
            this.Body = Body;
        }
    }
    
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.ServiceModel", "4.0.0.0")]
    [System.ComponentModel.EditorBrowsableAttribute(System.ComponentModel.EditorBrowsableState.Advanced)]
    [System.Runtime.Serialization.DataContractAttribute(Namespace="http://tempuri.org/")]
    public partial class getEmpresaDadosDatabaseRequestBody {
        
        [System.Runtime.Serialization.DataMemberAttribute(Order=0)]
        public int Database;
        
        public getEmpresaDadosDatabaseRequestBody() {
        }
        
        public getEmpresaDadosDatabaseRequestBody(int Database) {
            this.Database = Database;
        }
    }
    
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.ServiceModel", "4.0.0.0")]
    [System.ComponentModel.EditorBrowsableAttribute(System.ComponentModel.EditorBrowsableState.Advanced)]
    [System.ServiceModel.MessageContractAttribute(IsWrapped=false)]
    public partial class getEmpresaDadosDatabaseResponse {
        
        [System.ServiceModel.MessageBodyMemberAttribute(Name="getEmpresaDadosDatabaseResponse", Namespace="http://tempuri.org/", Order=0)]
        public Asseponto.DataBaseControl_GetDataBaseById.getEmpresaDadosDatabaseResponseBody Body;
        
        public getEmpresaDadosDatabaseResponse() {
        }
        
        public getEmpresaDadosDatabaseResponse(Asseponto.DataBaseControl_GetDataBaseById.getEmpresaDadosDatabaseResponseBody Body) {
            this.Body = Body;
        }
    }
    
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.ServiceModel", "4.0.0.0")]
    [System.ComponentModel.EditorBrowsableAttribute(System.ComponentModel.EditorBrowsableState.Advanced)]
    [System.Runtime.Serialization.DataContractAttribute(Namespace="http://tempuri.org/")]
    public partial class getEmpresaDadosDatabaseResponseBody {
        
        [System.Runtime.Serialization.DataMemberAttribute(EmitDefaultValue=false, Order=0)]
        public string getEmpresaDadosDatabaseResult;
        
        public getEmpresaDadosDatabaseResponseBody() {
        }
        
        public getEmpresaDadosDatabaseResponseBody(string getEmpresaDadosDatabaseResult) {
            this.getEmpresaDadosDatabaseResult = getEmpresaDadosDatabaseResult;
        }
    }
    
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.ServiceModel", "4.0.0.0")]
    [System.ComponentModel.EditorBrowsableAttribute(System.ComponentModel.EditorBrowsableState.Advanced)]
    [System.ServiceModel.MessageContractAttribute(IsWrapped=false)]
    public partial class getDatabasesRequest {
        
        [System.ServiceModel.MessageBodyMemberAttribute(Name="getDatabases", Namespace="http://tempuri.org/", Order=0)]
        public Asseponto.DataBaseControl_GetDataBaseById.getDatabasesRequestBody Body;
        
        public getDatabasesRequest() {
        }
        
        public getDatabasesRequest(Asseponto.DataBaseControl_GetDataBaseById.getDatabasesRequestBody Body) {
            this.Body = Body;
        }
    }
    
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.ServiceModel", "4.0.0.0")]
    [System.ComponentModel.EditorBrowsableAttribute(System.ComponentModel.EditorBrowsableState.Advanced)]
    [System.Runtime.Serialization.DataContractAttribute(Namespace="http://tempuri.org/")]
    public partial class getDatabasesRequestBody {
        
        [System.Runtime.Serialization.DataMemberAttribute(Order=0)]
        public int sistema;
        
        public getDatabasesRequestBody() {
        }
        
        public getDatabasesRequestBody(int sistema) {
            this.sistema = sistema;
        }
    }
    
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.ServiceModel", "4.0.0.0")]
    [System.ComponentModel.EditorBrowsableAttribute(System.ComponentModel.EditorBrowsableState.Advanced)]
    [System.ServiceModel.MessageContractAttribute(IsWrapped=false)]
    public partial class getDatabasesResponse {
        
        [System.ServiceModel.MessageBodyMemberAttribute(Name="getDatabasesResponse", Namespace="http://tempuri.org/", Order=0)]
        public Asseponto.DataBaseControl_GetDataBaseById.getDatabasesResponseBody Body;
        
        public getDatabasesResponse() {
        }
        
        public getDatabasesResponse(Asseponto.DataBaseControl_GetDataBaseById.getDatabasesResponseBody Body) {
            this.Body = Body;
        }
    }
    
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.ServiceModel", "4.0.0.0")]
    [System.ComponentModel.EditorBrowsableAttribute(System.ComponentModel.EditorBrowsableState.Advanced)]
    [System.Runtime.Serialization.DataContractAttribute(Namespace="http://tempuri.org/")]
    public partial class getDatabasesResponseBody {
        
        [System.Runtime.Serialization.DataMemberAttribute(EmitDefaultValue=false, Order=0)]
        public string getDatabasesResult;
        
        public getDatabasesResponseBody() {
        }
        
        public getDatabasesResponseBody(string getDatabasesResult) {
            this.getDatabasesResult = getDatabasesResult;
        }
    }
    
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.ServiceModel", "4.0.0.0")]
    public interface DatabasesSoapChannel : Asseponto.DataBaseControl_GetDataBaseById.DatabasesSoap, System.ServiceModel.IClientChannel {
    }
    
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.ServiceModel", "4.0.0.0")]
    public partial class DatabasesSoapClient : System.ServiceModel.ClientBase<Asseponto.DataBaseControl_GetDataBaseById.DatabasesSoap>, Asseponto.DataBaseControl_GetDataBaseById.DatabasesSoap {
        
        public DatabasesSoapClient() {
        }
        
        public DatabasesSoapClient(string endpointConfigurationName) : 
                base(endpointConfigurationName) {
        }
        
        public DatabasesSoapClient(string endpointConfigurationName, string remoteAddress) : 
                base(endpointConfigurationName, remoteAddress) {
        }
        
        public DatabasesSoapClient(string endpointConfigurationName, System.ServiceModel.EndpointAddress remoteAddress) : 
                base(endpointConfigurationName, remoteAddress) {
        }
        
        public DatabasesSoapClient(System.ServiceModel.Channels.Binding binding, System.ServiceModel.EndpointAddress remoteAddress) : 
                base(binding, remoteAddress) {
        }
        
        [System.ComponentModel.EditorBrowsableAttribute(System.ComponentModel.EditorBrowsableState.Advanced)]
        Asseponto.DataBaseControl_GetDataBaseById.getEmpresaDadosCnpjResponse Asseponto.DataBaseControl_GetDataBaseById.DatabasesSoap.getEmpresaDadosCnpj(Asseponto.DataBaseControl_GetDataBaseById.getEmpresaDadosCnpjRequest request) {
            return base.Channel.getEmpresaDadosCnpj(request);
        }
        
        public string getEmpresaDadosCnpj(string cnpj) {
            Asseponto.DataBaseControl_GetDataBaseById.getEmpresaDadosCnpjRequest inValue = new Asseponto.DataBaseControl_GetDataBaseById.getEmpresaDadosCnpjRequest();
            inValue.Body = new Asseponto.DataBaseControl_GetDataBaseById.getEmpresaDadosCnpjRequestBody();
            inValue.Body.cnpj = cnpj;
            Asseponto.DataBaseControl_GetDataBaseById.getEmpresaDadosCnpjResponse retVal = ((Asseponto.DataBaseControl_GetDataBaseById.DatabasesSoap)(this)).getEmpresaDadosCnpj(inValue);
            return retVal.Body.getEmpresaDadosCnpjResult;
        }
        
        [System.ComponentModel.EditorBrowsableAttribute(System.ComponentModel.EditorBrowsableState.Advanced)]
        Asseponto.DataBaseControl_GetDataBaseById.getEmpresaDadosEmailResponse Asseponto.DataBaseControl_GetDataBaseById.DatabasesSoap.getEmpresaDadosEmail(Asseponto.DataBaseControl_GetDataBaseById.getEmpresaDadosEmailRequest request) {
            return base.Channel.getEmpresaDadosEmail(request);
        }
        
        public string getEmpresaDadosEmail(string email) {
            Asseponto.DataBaseControl_GetDataBaseById.getEmpresaDadosEmailRequest inValue = new Asseponto.DataBaseControl_GetDataBaseById.getEmpresaDadosEmailRequest();
            inValue.Body = new Asseponto.DataBaseControl_GetDataBaseById.getEmpresaDadosEmailRequestBody();
            inValue.Body.email = email;
            Asseponto.DataBaseControl_GetDataBaseById.getEmpresaDadosEmailResponse retVal = ((Asseponto.DataBaseControl_GetDataBaseById.DatabasesSoap)(this)).getEmpresaDadosEmail(inValue);
            return retVal.Body.getEmpresaDadosEmailResult;
        }
        
        [System.ComponentModel.EditorBrowsableAttribute(System.ComponentModel.EditorBrowsableState.Advanced)]
        Asseponto.DataBaseControl_GetDataBaseById.getEmpresaDadosDatabaseResponse Asseponto.DataBaseControl_GetDataBaseById.DatabasesSoap.getEmpresaDadosDatabase(Asseponto.DataBaseControl_GetDataBaseById.getEmpresaDadosDatabaseRequest request) {
            return base.Channel.getEmpresaDadosDatabase(request);
        }
        
        public string getEmpresaDadosDatabase(int Database) {
            Asseponto.DataBaseControl_GetDataBaseById.getEmpresaDadosDatabaseRequest inValue = new Asseponto.DataBaseControl_GetDataBaseById.getEmpresaDadosDatabaseRequest();
            inValue.Body = new Asseponto.DataBaseControl_GetDataBaseById.getEmpresaDadosDatabaseRequestBody();
            inValue.Body.Database = Database;
            Asseponto.DataBaseControl_GetDataBaseById.getEmpresaDadosDatabaseResponse retVal = ((Asseponto.DataBaseControl_GetDataBaseById.DatabasesSoap)(this)).getEmpresaDadosDatabase(inValue);
            return retVal.Body.getEmpresaDadosDatabaseResult;
        }
        
        [System.ComponentModel.EditorBrowsableAttribute(System.ComponentModel.EditorBrowsableState.Advanced)]
        Asseponto.DataBaseControl_GetDataBaseById.getDatabasesResponse Asseponto.DataBaseControl_GetDataBaseById.DatabasesSoap.getDatabases(Asseponto.DataBaseControl_GetDataBaseById.getDatabasesRequest request) {
            return base.Channel.getDatabases(request);
        }
        
        public string getDatabases(int sistema) {
            Asseponto.DataBaseControl_GetDataBaseById.getDatabasesRequest inValue = new Asseponto.DataBaseControl_GetDataBaseById.getDatabasesRequest();
            inValue.Body = new Asseponto.DataBaseControl_GetDataBaseById.getDatabasesRequestBody();
            inValue.Body.sistema = sistema;
            Asseponto.DataBaseControl_GetDataBaseById.getDatabasesResponse retVal = ((Asseponto.DataBaseControl_GetDataBaseById.DatabasesSoap)(this)).getDatabases(inValue);
            return retVal.Body.getDatabasesResult;
        }
    }
}