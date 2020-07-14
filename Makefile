fmt:
	terraform12 fmt -check -no-color -recursive -diff

lint:
	terraform12 init -backend=false -no-color

validate:
	terraform12 validate -no-color

test: fmt lint validate
	
