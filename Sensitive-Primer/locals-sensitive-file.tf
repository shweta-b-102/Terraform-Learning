resource "local_sensitive_file" "foo" {
    content = "passwrdsecrt@word"
    filename = "test.txt"
}


/* If you try to reference sensistive value in output values, terraform  will immediately
immdidetaly give an error. but if we but sensitive as true it will give pass = <sensitive> in cli but passwd is 
not visible
*/
output "pass" {
    value = local_sensitive_file.foo.content
    sensitive = true
  
}