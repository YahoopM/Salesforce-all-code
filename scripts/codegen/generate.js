const fs = require('fs');
const path = require('path');

function ensureDir(dir) {
  if (!fs.existsSync(dir)) {
    fs.mkdirSync(dir, { recursive: true });
  }
}

function toApexName(str) {
  return str.replace(/[^A-Za-z0-9]+/g, ' ').trim().split(/\s+/).map(s => s.charAt(0).toUpperCase() + s.slice(1)).join('');
}

const ticketKey = process.env.TICKET_KEY || 'TICKET-000';
const title = process.env.TICKET_TITLE || 'Generated Change';
const description = process.env.TICKET_DESC || '';

const classesDir = path.join(process.cwd(), 'force-app', 'main', 'default', 'classes');
ensureDir(classesDir);

const className = toApexName(`${ticketKey}_${title}`).slice(0, 35).replace(/_+/g, '');
const apexClassName = `${className}`;

const apexPath = path.join(classesDir, `${apexClassName}.cls`);
const metaPath = path.join(classesDir, `${apexClassName}.cls-meta.xml`);

const apexContent =
`public with sharing class ${apexClassName} {
    /**
     * Auto-generated scaffold for ${ticketKey}: ${title}
     * ${description}
     */
    public static String info() {
        return '${ticketKey}: ${title}'.trim();
    }
}
`;

const metaContent =
`<?xml version="1.0" encoding="UTF-8"?>
<ApexClass xmlns="http://soap.sforce.com/2006/04/metadata">
    <apiVersion>61.0</apiVersion>
    <status>Active</status>
</ApexClass>
`;

if (!fs.existsSync(apexPath)) {
  fs.writeFileSync(apexPath, apexContent, 'utf8');
}
if (!fs.existsSync(metaPath)) {
  fs.writeFileSync(metaPath, metaContent, 'utf8');
}

console.log(`Generated ${apexClassName} in classes directory.`);



