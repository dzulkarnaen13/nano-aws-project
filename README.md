cat << 'EOF' > README.md
# 🚀 S3 Static Website Deployment using AWS CLI

---

## 🎯 Objective

This project demonstrates a complete end-to-end workflow using:

- Linux Bash (CLI)
- AWS CLI
- Amazon S3 (Static Website Hosting)

Goal:

✔ Create local file  
✔ Upload to AWS S3  
✔ Configure public website  
✔ Test using HTTP  
✔ Clean up resources  

👉 If the website is accessible → SUCCESS ✅

---

## 🧠 Architecture

Local Machine (Bash CLI)
        ↓
   AWS S3 Bucket
        ↓
 Public Website (HTTP)

---

## 🔁 Workflow

CREATE → VERIFY → CREATE BUCKET → UPLOAD → VERIFY → CONFIG → TEST → DELETE

---

# 🟢 PHASE 1 — CREATE (LOCAL)

## STEP 1 — Create Project Folder

cd ~  
mkdir nano1-test && cd nano1-test  

---

## STEP 2 — Create HTML File

nano index.html  

Example:

<h1>Hello AWS</h1>  
<p>nano daily practice</p>  

---

# 🔵 PHASE 2 — VERIFY

## STEP 3 — Check File

ls  
cat index.html  

---

# 🟣 PHASE 3 — CREATE BUCKET

## STEP 4 — Generate Unique Bucket Name

TS=$(date +%s)  
BUCKET=nano1-test-$TS  
echo $BUCKET  

👉 Bucket must be globally unique  

---

## STEP 5 — Create S3 Bucket

aws s3 mb s3://$BUCKET --region ap-southeast-1  

---

# 🟡 PHASE 4 — UPLOAD

## STEP 6 — Upload File

aws s3 cp index.html s3://$BUCKET/  

---

# 🔵 PHASE 5 — VERIFY UPLOAD

## STEP 7 — Verify File in S3

aws s3 ls s3://$BUCKET/  

---

# 🟠 PHASE 6 — CONFIGURE WEBSITE

## STEP 8 — Enable Static Website Hosting

aws s3 website s3://$BUCKET/ --index-document index.html  

---

## STEP 9 — Disable Block Public Access

aws s3api put-public-access-block \
--bucket $BUCKET \
--public-access-block-configuration '{
  "BlockPublicAcls": false,
  "IgnorePublicAcls": false,
  "BlockPublicPolicy": false,
  "RestrictPublicBuckets": false
}'

---

## STEP 10 — Apply Public Read Policy

aws s3api put-bucket-policy --bucket $BUCKET --policy '{
  "Version":"2012-10-17",
  "Statement":[{
    "Effect":"Allow",
    "Principal": "*",
    "Action":["s3:GetObject"],
    "Resource":["arn:aws:s3:::'"$BUCKET"'/*"]
  }]
}'

---

# 🟢 PHASE 7 — TEST

## STEP 11 — Test Website

URL="http://$BUCKET.s3-website-ap-southeast-1.amazonaws.com"  
echo $URL  

curl $URL  
curl -I $URL  

---

## ✅ Expected Output

curl $URL  

<h1>Hello AWS</h1>  
<p>nano daily practice</p>  

curl -I $URL  

HTTP/1.1 200 OK  
Content-Type: text/html  

---

# 🔴 PHASE 8 — CLEANUP

## STEP 12 — Delete Resources

aws s3 rm s3://$BUCKET --recursive  
aws s3 rb s3://$BUCKET  

cd ~  
rm -rf nano1-test  

---

# ❌ Common Errors

1. Bucket name invalid  
Fix: gunakan timestamp  

2. Access Denied  
Fix: disable public access block  

3. Terminal stuck ">"  
Fix: CTRL + C  

4. Typo command  
aws (correct), bukan ws  

---

# 🧠 Bash Guide

## ✅ Must Know
cd, mkdir, ls, cat, nano  
$VAR, $(date +%s)  
aws s3 mb, cp, ls  
curl  

## ⚠️ Understand
aws s3api structure  

## 📋 Copy-Paste
JSON policy  

## 🟡 Custom
folder name  
file name  
bucket name  

---

# 🧱 Skills Practiced

- Bash CLI  
- AWS CLI  
- S3 hosting  
- Debugging  
- Deployment workflow  

---

# ✅ Success Criteria

✔ Bucket created  
✔ File uploaded  
✔ Website accessible  
✔ HTTP 200 OK  
✔ Resources deleted  

---

# 🚀 Why This Project Matters

- Demonstrates real AWS CLI usage  
- Shows understanding of S3 hosting  
- Proves ability to debug issues  
- End-to-end cloud workflow  

👉 Suitable as beginner cloud portfolio project  

---

# 💡 Notes

- nano used for learning  
- real project use VSCode / CI/CD  
- workflow remains the same  
EOF
