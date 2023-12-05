import json

res = {
    'error_dict' : {
                'bind_error' : [],
                'catalog_error' : [],
                'parse_error' : [],
                'conversion_error' : [],
                'bind_error_count': 0,
                'catalog_error_count': 0,
                'parse_error_count': 0,
                'conversion_error_count':0
                },
    'success' :{
        'success' : [],
        'success_count' : 0,
    },
    'acc_metrics' : {
            'compilation_acc':1.0, #number of successfully compiled queries, obeys syntax of the language
            'execution_acc':1.0, #number of successful executions, runs on the db and generates some output
        }
}



for i in range(1,100):
    path = f"../logs/query-output-log{i}.txt"
    with open(path,'r') as f:
        content = f.read()
        #print(content)
        if content.startswith("Catalog Error"):
            res['error_dict']['catalog_error'].append(i)
            res['error_dict']['catalog_error_count'] += 1
        elif content.startswith("Parser Error"):
            res['error_dict']['parse_error'].append(i)
            res['error_dict']['parse_error_count'] += 1
        elif content.startswith("Binder Error"):
            res['error_dict']['bind_error'].append(i)
            res['error_dict']['bind_error_count'] += 1
        elif content.startswith("Conversion Error"):
            res['error_dict']['conversion_error'].append(i)
            res['error_dict']['conversion_error_count'] += 1
        elif content.startswith("Sucess"):
            res['success']['success'].append(i)
            res['success']['success_count'] += 1
        

#print(error_dict['success_count'] + error_dict['bind_error_count']+ error_dict['parse_error_count']+ error_dict['catalog_error_count'])
#assert error_dict['success_count'] + error_dict['bind_error_count']+ error_dict['parse_error_count']+ error_dict['catalog_error_count']+error_dict['conversion_error_count'] == 99
res['acc_metrics']['compilation_acc'] = round(1 - (res['error_dict']['parse_error_count']/99),5)
res['acc_metrics']['execution_acc'] = round(res['success']['success_count']/99,5)


with open('../results.json','w') as f:
    json.dump(res, f, indent=3)
   