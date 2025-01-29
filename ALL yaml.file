# yamlfile.yml
/////////////////////////////////////////////////////
********yamal file for one pod*******
apiVersion: v1
kind: Pod
metadata:
  name: pod-a
spec:
  containers:
  - name: tomcat
    image: tomcat
    ports:
    - containerPort: 80
    

////////////////////////////////////////
*********ONE POD + TWO CONTAINER********

apiVersion: v1
kind: Pod
metadata:
  name: pod-a
spec:
  containers:
    - name: tomcat
      image: tomcat
      ports:
        - containerPort: 80
    - name: tomcat
      image: tomcat
      ports:
        - name: tomcat
          containerPort: 8080
    - name: apache
      image: httpd
      ports:
        - name: http
          containerPort: 80
//////////////////////////////////////////////////////////
******two pod + one pod contain 2-container & 2second pod contain 1-container*******

apiVersion: v1
kind: Pod
metadata:
  name: my-pod
spec:
  containers:
    - name: httpd
      image: httpd:latest
      ports:
        - containerPort: 80
    - name: tomcat
      image: tomcat
      ports:
        - containerPort: 8080

---
apiVersion: v1
kind: Pod
metadata:
  name: another-pod
spec:
  containers:
    - name: httpd
      image: httpd:latest
      ports:
        - containerPort: 80

/////////////////////////////////
****yaml file for service*****
apiVersion: v1
kind: Service
metadata:
  name: my-service
spec:
  ports:
    - targetPort: 8080
      port: 8080
      protocol: TCP
      name: java
  selector:
    app: my-app
///////////////////////////
****yaml for name spce****
apiVersion: v1
kind: Namespace
metadata: name:prod

///////////////////////////
*********yaml for controller*****
