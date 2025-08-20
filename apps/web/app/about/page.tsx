import React from 'react'
import Link from 'next/link'
import { Button } from '@/components/ui/button'

export default function AboutPage() {
  return (
    <div className="min-h-screen">
      {/* Header */}
      <header className="border-b border-border/40 bg-background/95 backdrop-blur supports-[backdrop-filter]:bg-background/60">
        <div className="container mx-auto px-4 sm:px-6 lg:px-8">
          <div className="flex h-16 items-center justify-between">
            <div className="flex items-center">
              <Link href="/" className="text-xl font-bold text-foreground">
                Sodium
              </Link>
            </div>
            <nav className="hidden md:flex items-center space-x-6">
              <Link href="/features" className="text-sm font-medium text-muted-foreground hover:text-foreground transition-colors">
                Features
              </Link>
              <Link href="/about" className="text-sm font-medium text-foreground transition-colors">
                About
              </Link>
              <Link href="/contact" className="text-sm font-medium text-muted-foreground hover:text-foreground transition-colors">
                Contact
              </Link>
            </nav>
          </div>
        </div>
      </header>

      {/* Main Content */}
      <main className="py-20 px-4 sm:px-6 lg:px-8">
        <div className="container mx-auto max-w-4xl">
          <div className="text-center mb-16">
            <h1 className="text-4xl sm:text-5xl font-bold text-foreground mb-6">
              About Sodium
            </h1>
            <p className="text-xl text-muted-foreground max-w-2xl mx-auto">
              A modern web application built with cutting-edge technologies and best practices.
            </p>
          </div>

          <div className="grid grid-cols-1 lg:grid-cols-2 gap-12 mb-16">
            <div>
              <h2 className="text-2xl font-semibold text-foreground mb-4">Our Mission</h2>
              <p className="text-muted-foreground leading-relaxed">
                We believe in creating exceptional digital experiences that are both beautiful and functional. 
                Our team is passionate about leveraging the latest technologies to build applications that 
                users love to use and developers love to maintain.
              </p>
            </div>
            <div>
              <h2 className="text-2xl font-semibold text-foreground mb-4">Our Vision</h2>
              <p className="text-muted-foreground leading-relaxed">
                To become the leading platform for modern web development, providing tools and frameworks 
                that enable developers to build faster, more reliable, and more scalable applications.
              </p>
            </div>
          </div>

          <div className="card mb-16">
            <h2 className="text-2xl font-semibold text-foreground mb-6">Technology Stack</h2>
            <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
              <div className="text-center">
                <div className="w-16 h-16 bg-primary/10 rounded-lg flex items-center justify-center mx-auto mb-4">
                  <svg className="w-8 h-8 text-primary" fill="currentColor" viewBox="0 0 24 24">
                    <path d="M12 2L2 7l10 5 10-5-10-5zM2 17l10 5 10-5M2 12l10 5 10-5"/>
                  </svg>
                </div>
                <h3 className="text-lg font-semibold text-foreground mb-2">Next.js</h3>
                <p className="text-sm text-muted-foreground">
                  React framework for production
                </p>
              </div>
              <div className="text-center">
                <div className="w-16 h-16 bg-primary/10 rounded-lg flex items-center justify-center mx-auto mb-4">
                  <svg className="w-8 h-8 text-primary" fill="currentColor" viewBox="0 0 24 24">
                    <path d="M12 2L2 7l10 5 10-5-10-5zM2 17l10 5 10-5M2 12l10 5 10-5"/>
                  </svg>
                </div>
                <h3 className="text-lg font-semibold text-foreground mb-2">TypeScript</h3>
                <p className="text-sm text-muted-foreground">
                  Type-safe JavaScript
                </p>
              </div>
              <div className="text-center">
                <div className="w-16 h-16 bg-primary/10 rounded-lg flex items-center justify-center mx-auto mb-4">
                  <svg className="w-8 h-8 text-primary" fill="currentColor" viewBox="0 0 24 24">
                    <path d="M12 2L2 7l10 5 10-5-10-5zM2 17l10 5 10-5M2 12l10 5 10-5"/>
                  </svg>
                </div>
                <h3 className="text-lg font-semibold text-foreground mb-2">Tailwind CSS</h3>
                <p className="text-sm text-muted-foreground">
                  Utility-first CSS framework
                </p>
              </div>
            </div>
          </div>

          <div className="text-center">
            <Button asChild>
              <Link href="/contact">
                Get in Touch
              </Link>
            </Button>
          </div>
        </div>
      </main>

      {/* Footer */}
      <footer className="border-t border-border/40 bg-background py-12 px-4 sm:px-6 lg:px-8">
        <div className="container mx-auto text-center">
          <p className="text-sm text-muted-foreground">
            © 2024 Sodium. All rights reserved.
          </p>
        </div>
      </footer>
    </div>
  )
}
