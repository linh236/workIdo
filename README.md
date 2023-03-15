# README
* Setup project

- Step 1: git clone git@github.com:linh236/workIdo.git
- Step 2: cd workIdo
- Step 3: rails db:migrate
- Step 4: rails s 
* Method 1: run `rails s`
 + if run error: The asset "tailwind.css" is not present in the asset pipeline. [Description](https://github.com/rails/tailwindcss-rails/issues/158)
 => fix: rails assets:clean && rails assets:precompile && rails s
 * Method 2: bin/dev ( Using TailwindCss )
* ...
# workIdo
* Dashboard
![image](https://user-images.githubusercontent.com/40066172/220827464-84e33ad4-15a3-4eba-839b-f90e6198aa23.png)
* Task detail ( Assign member, Comment task)
![Screenshot from 2023-03-13 12-51-40](https://user-images.githubusercontent.com/40066172/224618610-b6304a58-f90d-4ab2-b510-cfc1f0deff86.png)
* Profile
![Screenshot from 2023-03-13 17-17-00](https://user-images.githubusercontent.com/40066172/224673130-fff52030-4296-4045-a50a-40a8e62e780f.png)
* Comment tag user and notification
![Screenshot from 2023-03-14 11-21-10](https://user-images.githubusercontent.com/40066172/224892658-42d915c1-e805-4797-aef2-bda14ec8de36.png)
