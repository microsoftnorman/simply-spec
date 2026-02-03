#!/usr/bin/env node

/**
 * Validates a SKILL.md file for required elements and best practices
 * Usage: node validate-skill.js path/to/SKILL.md
 */

const fs = require('fs');
const path = require('path');

function validateSkill(filePath) {
  const content = fs.readFileSync(filePath, 'utf-8');
  const errors = [];
  const warnings = [];

  // Check for YAML frontmatter
  const frontmatterMatch = content.match(/^---\n([\s\S]*?)\n---/);
  if (!frontmatterMatch) {
    errors.push('Missing YAML frontmatter (---...---)');
  } else {
    const frontmatter = frontmatterMatch[1];
    
    // Check required fields
    if (!frontmatter.includes('name:')) {
      errors.push('Missing required field: name');
    } else {
      const nameMatch = frontmatter.match(/name:\s*(.+)/);
      if (nameMatch) {
        const name = nameMatch[1].trim();
        if (name !== name.toLowerCase()) {
          errors.push('Name must be lowercase');
        }
        if (name.includes(' ')) {
          errors.push('Name must use hyphens instead of spaces');
        }
      }
    }

    if (!frontmatter.includes('description:')) {
      errors.push('Missing required field: description');
    } else {
      const descMatch = frontmatter.match(/description:\s*(.+)/);
      if (descMatch) {
        const desc = descMatch[1].trim();
        if (desc.length < 20) {
          warnings.push('Description is very short - consider being more specific');
        }
        if (!desc.toLowerCase().includes('use this when') && 
            !desc.toLowerCase().includes('use when')) {
          warnings.push('Description should include trigger conditions (e.g., "Use this when...")');
        }
      }
    }

    if (!frontmatter.includes('license:')) {
      warnings.push('Consider adding a license field');
    }
  }

  // Check body content
  const body = content.replace(/^---[\s\S]*?---/, '').trim();
  
  if (body.length < 100) {
    errors.push('Skill body is too short - add detailed instructions');
  }

  // Check for recommended sections
  const recommendedSections = [
    { pattern: /#+.*when.*use/i, name: 'When to Use section' },
    { pattern: /#+.*process|#+.*steps/i, name: 'Process/Steps section' },
    { pattern: /#+.*example/i, name: 'Examples section' },
  ];

  for (const section of recommendedSections) {
    if (!section.pattern.test(body)) {
      warnings.push(`Consider adding: ${section.name}`);
    }
  }

  // Check for numbered steps
  if (!body.match(/^\d+\./m)) {
    warnings.push('Consider using numbered steps for processes');
  }

  // Check for code examples
  if (!body.includes('```')) {
    warnings.push('Consider adding code examples in fenced code blocks');
  }

  // Check for success criteria
  if (!body.toLowerCase().includes('success') && 
      !body.toLowerCase().includes('complete') &&
      !body.toLowerCase().includes('done')) {
    warnings.push('Consider adding success criteria to define when the task is complete');
  }

  // Output results
  console.log(`\nValidating: ${filePath}\n`);
  
  if (errors.length === 0 && warnings.length === 0) {
    console.log('✅ Skill passes all checks!\n');
    return true;
  }

  if (errors.length > 0) {
    console.log('❌ Errors (must fix):');
    errors.forEach(e => console.log(`   - ${e}`));
    console.log('');
  }

  if (warnings.length > 0) {
    console.log('⚠️  Warnings (consider fixing):');
    warnings.forEach(w => console.log(`   - ${w}`));
    console.log('');
  }

  return errors.length === 0;
}

// Main
const args = process.argv.slice(2);
if (args.length === 0) {
  console.log('Usage: node validate-skill.js path/to/SKILL.md');
  process.exit(1);
}

const filePath = args[0];
if (!fs.existsSync(filePath)) {
  console.error(`File not found: ${filePath}`);
  process.exit(1);
}

const isValid = validateSkill(filePath);
process.exit(isValid ? 0 : 1);
