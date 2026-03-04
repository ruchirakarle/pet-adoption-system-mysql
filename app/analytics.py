import matplotlib.pyplot as plt
import pandas as pd
from database import Database

class Analytics:
    def __init__(self):
        """Initialize analytics with database connection"""
        self.db = Database()
        self.db.connect()
    
    def chart_pets_by_species(self):
        """CHART 1: Pets distribution by species - PIE CHART"""
        print("\n📊 Generating chart: Pets by Species ...")
        
        try:
            data = self.db.fetch_query("""
                SELECT s.species_name, COUNT(p.pet_id) as count
                FROM Species s
                LEFT JOIN Pets p ON s.species_id = p.species_id
                GROUP BY s.species_name
                HAVING COUNT(p.pet_id) > 0
                ORDER BY count DESC
            """)
            
            if not data:
                print("❌ No data available for chart.")
                return
            
            df = pd.DataFrame(data)
            
            # Creates the pie chart
            fig, ax = plt.subplots(figsize=(10, 8))
            
            # Color palette for my chart
            colors = ['#3498db', '#e74c3c', '#2ecc71', '#f39c12', '#9b59b6', 
                     '#1abc9c', '#e67e22', '#95a5a6']
            
            # Create pie chart with explosion for emphasis
            explode = [0.05] * len(df)  # Slightly separate all slices
            explode[0] = 0.1  # Emphasize the largest slice
            
            wedges, texts, autotexts = ax.pie(
                df['count'], 
                labels=df['species_name'],
                autopct='%1.1f%%',
                startangle=90,
                colors=colors[:len(df)],
                explode=explode,
                shadow=True,
                textprops={'fontsize': 11, 'fontweight': 'bold'}
            )
            
            # this Makes percentage text white and bold
            for autotext in autotexts:
                autotext.set_color('white')
                autotext.set_fontweight('bold')
                autotext.set_fontsize(12)
            
            # Add count labels
            for i, (species, count) in enumerate(zip(df['species_name'], df['count'])):
                texts[i].set_text(f'{species}\n({int(count)} pets)')
                texts[i].set_fontsize(10)
                texts[i].set_fontweight('bold')
            
            # Title
            ax.set_title('Pet Distribution by Species in Shelter System', 
                        fontsize=15, fontweight='bold', pad=20)
            
            
            ax.axis('equal')
            
            plt.tight_layout()
            
            # Save chart as png 
            filename = 'pets_by_species.png'
            plt.savefig(filename, dpi=300, bbox_inches='tight')
            print(f"✅ Chart saved as '{filename}'")
            plt.show()
            
        except Exception as e:
            print(f"❌ Error generating chart: {e}")
    


    def chart_shelter_occupancy(self):
        """ CHART 2: Shelter occupancy rates with color coding"""
        print("\n📊 Generating chart: Shelter Occupancy...")
        
        try:
            data = self.db.fetch_query("""
                SELECT 
                    s.name as shelter_name,
                    s.capacity,
                    COUNT(CASE WHEN p.status != 'Adopted' THEN 1 END) as current_pets,
                    fn_shelter_occupancy_rate(s.shelter_id) as occupancy_rate
                FROM Shelter s
                LEFT JOIN Pets p ON s.shelter_id = p.shelter_id
                GROUP BY s.shelter_id, s.name, s.capacity
                ORDER BY occupancy_rate DESC
            """)
            
            if not data:
                print("❌ No data available for chart.")
                return
            
            df = pd.DataFrame(data)
            
            colors = []
            for rate in df['occupancy_rate']:
                rate = float(rate)
                if rate > 80:
                    colors.append('#e74c3c')  # Red - Critical meaning almost full
                elif rate > 60:
                    colors.append('#f39c12')  # Orange - High but still enough space
                else:
                    colors.append('#2ecc71')  # Green - Good
            
            # Create horizontal bar chart
            plt.figure(figsize=(12, 6))
            bars = plt.barh(df['shelter_name'], df['occupancy_rate'], 
                           color=colors, edgecolor='black', linewidth=1.5)
            
            # Add value labels
            for i, (bar, rate, current, capacity) in enumerate(zip(bars, df['occupancy_rate'], 
                                                                    df['current_pets'], df['capacity'])):
                width = bar.get_width()
                plt.text(width + 2, bar.get_y() + bar.get_height()/2.,
                        f'{float(rate):.1f}% ({int(current)}/{int(capacity)})',
                        ha='left', va='center', fontweight='bold')
            
            
            plt.axvline(x=80, color='#e74c3c', linestyle='--', linewidth=2, 
                       label='Critical Level (80%)', alpha=0.7)
            plt.axvline(x=60, color='#f39c12', linestyle='--', linewidth=2, 
                       label='High Level (60%)', alpha=0.7)
            
            plt.xlabel('Occupancy Rate (%)', fontsize=12, fontweight='bold')
            plt.ylabel('Shelter', fontsize=12, fontweight='bold')
            plt.title('Shelter Occupancy Rates (Current Pets / Capacity)', 
                     fontsize=14, fontweight='bold', pad=20)
            plt.xlim(0, max(100, max(df['occupancy_rate']) + 10))
            plt.legend(loc='lower right')
            plt.grid(axis='x', alpha=0.3, linestyle='--')
            plt.tight_layout()
            
            # Save chart as png
            filename = 'shelter_occupancy.png'
            plt.savefig(filename, dpi=300, bbox_inches='tight')
            print(f"✅ Chart saved as '{filename}'")
            plt.show()
            
        except Exception as e:
            print(f"❌ Error generating chart: {e}")
    


    def chart_adoption_trends(self):
        """CHART 3: Monthly adoption trends """
        print("\n📊 Generating chart: Adoption Trends...")
        
        try:
            data = self.db.fetch_query("""
                SELECT 
                    DATE_FORMAT(adoption_date, '%Y-%m') as month,
                    COUNT(*) as adoptions,
                    AVG(DATEDIFF(adoption_date, intake_date)) as avg_days_to_adopt
                FROM Pets
                WHERE adoption_date IS NOT NULL
                GROUP BY month
                ORDER BY month
            """)
            
            if not data:
                print("❌ No adoption data available yet.")
                return
            
            df = pd.DataFrame(data)
            
            # Create figure with two subplots
            fig, (ax1, ax2) = plt.subplots(1, 2, figsize=(14, 6))
            
            # Plot 1: Number of adoptions
            ax1.plot(df['month'], df['adoptions'], marker='o', 
                    linewidth=2, color='#2ecc71', markersize=8)
            ax1.set_xlabel('Month', fontsize=11, fontweight='bold')
            ax1.set_ylabel('Number of Adoptions', fontsize=11, fontweight='bold')
            ax1.set_title('Monthly Adoptions', fontsize=13, fontweight='bold')
            ax1.grid(True, alpha=0.3)
            ax1.tick_params(axis='x', rotation=45)
            
            # Add value labels
            for i, (month, adoptions) in enumerate(zip(df['month'], df['adoptions'])):
                ax1.text(i, adoptions + 0.1, str(int(adoptions)), 
                        ha='center', va='bottom', fontsize=9)
            
            # Plot 2: Average days to adoption when adopter submits this application
            ax2.bar(df['month'], df['avg_days_to_adopt'], 
                   color='#3498db', edgecolor='black')
            ax2.set_xlabel('Month', fontsize=11, fontweight='bold')
            ax2.set_ylabel('Average Days', fontsize=11, fontweight='bold')
            ax2.set_title('Average Time to Adoption', fontsize=13, fontweight='bold')
            ax2.tick_params(axis='x', rotation=45)
            ax2.grid(axis='y', alpha=0.3)
            
            plt.tight_layout()
            filename = 'adoption_trends.png'
            plt.savefig(filename, dpi=300, bbox_inches='tight')
            print(f"✅ Chart saved as '{filename}'")
            plt.show()
            
        except Exception as e:
            print(f"❌ Error generating chart: {e}")
    


    def generate_statistics_report(self):
        """REPORT: Comprehensive statistics report """
        print("\n" + "="*60)
        print("📊 STATISTICAL ANALYSIS REPORT")
        print("="*60)
        
        try:
            # 1. Overall statistics of our data 
            overall = self.db.fetch_query("""
                SELECT 
                    COUNT(*) as total_pets,
                    SUM(CASE WHEN status = 'Available' THEN 1 ELSE 0 END) as available,
                    SUM(CASE WHEN status = 'Adopted' THEN 1 ELSE 0 END) as adopted,
                    SUM(CASE WHEN status = 'Under Review' THEN 1 ELSE 0 END) as under_review,
                    ROUND(AVG(age), 1) as avg_age,
                    ROUND(SUM(CASE WHEN status = 'Adopted' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 1) as adoption_rate
                FROM Pets
            """)[0]
            
            print("\n📈 Overall Pet Statistics:")
            print(f"   Total Pets in System: {overall['total_pets']}")
            print(f"   Available for Adoption: {overall['available']}")
            print(f"   Successfully Adopted: {overall['adopted']}")
            print(f"   Under Review: {overall['under_review']}")
            print(f"   Average Pet Age: {overall['avg_age']} years")
            print(f"   Overall Adoption Rate: {overall['adoption_rate']}%")
            
            # 2. Species breakdown
            species_stats = self.db.fetch_query("""
                SELECT 
                    s.species_name,
                    COUNT(p.pet_id) as total,
                    SUM(CASE WHEN p.status = 'Adopted' THEN 1 ELSE 0 END) as adopted,
                    SUM(CASE WHEN p.status = 'Available' THEN 1 ELSE 0 END) as available,
                    ROUND(AVG(p.age), 1) as avg_age
                FROM Species s
                LEFT JOIN Pets p ON s.species_id = p.species_id
                GROUP BY s.species_id, s.species_name
                ORDER BY total DESC
            """)
            
            print("\n📊 Breakdown by Species:")
            print(f"   {'Species':<15} | {'Total':>5} | {'Available':>9} | {'Adopted':>7} | {'Rate':>6} | {'Avg Age':>7}")
            print("   " + "-"*67)
            for sp in species_stats:
                if sp['total'] > 0:
                    adoption_pct = (sp['adopted'] / sp['total'] * 100) if sp['total'] > 0 else 0
                    print(f"   {sp['species_name']:<15} | {sp['total']:>5} | {sp['available']:>9} | {sp['adopted']:>7} | {adoption_pct:>5.1f}% | {sp['avg_age']:>7}")
            
            # 3. Shelter performance
            shelter_stats = self.db.fetch_query("""
                SELECT 
                    sh.name,
                    sh.capacity,
                    COUNT(CASE WHEN p.status != 'Adopted' THEN 1 END) as current_pets,
                    SUM(CASE WHEN p.status = 'Adopted' THEN 1 ELSE 0 END) as total_adopted,
                    fn_shelter_occupancy_rate(sh.shelter_id) as occupancy
                FROM Shelter sh
                LEFT JOIN Pets p ON sh.shelter_id = p.shelter_id
                GROUP BY sh.shelter_id, sh.name, sh.capacity
                ORDER BY total_adopted DESC
            """)
            
            print("\n🏠 Shelter Performance:")
            for shelter in shelter_stats:
                print(f"\n   {shelter['name']}")
                print(f"      Capacity: {shelter['capacity']} pets")
                print(f"      Current Occupancy: {float(shelter['occupancy']):.1f}% ({shelter['current_pets']} pets)")
                print(f"      Total Adoptions: {shelter['total_adopted']}")
                
                # Occupancy status for all pets 
                occ = float(shelter['occupancy'])
                if occ > 80:
                    print(f"      Status: 🔴 CRITICAL - Over capacity!")
                elif occ > 60:
                    print(f"      Status: 🟠 HIGH - Nearing capacity")
                else:
                    print(f"      Status: 🟢 GOOD - Adequate space")
            
            # 4. Application statistics
            app_stats = self.db.fetch_query("""
                SELECT 
                    COUNT(*) as total_apps,
                    SUM(CASE WHEN status = 'Pending' THEN 1 ELSE 0 END) as pending,
                    SUM(CASE WHEN status = 'Approved' THEN 1 ELSE 0 END) as approved,
                    SUM(CASE WHEN status = 'Rejected' THEN 1 ELSE 0 END) as rejected,
                    ROUND(SUM(CASE WHEN status = 'Approved' THEN 1 ELSE 0 END) * 100.0 / 
                          NULLIF(COUNT(*), 0), 1) as approval_rate
                FROM Application
            """)[0]
            
            print("\n📝 Application Statistics:")
            print(f"   Total Applications Received: {app_stats['total_apps']}")
            print(f"   Pending Review: {app_stats['pending']}")
            print(f"   Approved: {app_stats['approved']}")
            print(f"   Rejected: {app_stats['rejected']}")
            if app_stats['approval_rate']:
                print(f"   Approval Rate: {app_stats['approval_rate']}%")
            
            # 5. Top adopters in db
            top_adopters = self.db.fetch_query("""
                SELECT 
                    a.adp_name,
                    a.city,
                    COUNT(app.app_id) as total_applications,
                    SUM(CASE WHEN app.status = 'Approved' THEN 1 ELSE 0 END) as approved
                FROM Adopters a
                LEFT JOIN Application app ON a.adp_id = app.adp_id
                GROUP BY a.adp_id, a.adp_name, a.city
                HAVING COUNT(app.app_id) > 0
                ORDER BY approved DESC, total_applications DESC
                LIMIT 5
            """)
            
            if top_adopters:
                print("\n👥 Top 5 Most Active Adopters:")
                for i, adopter in enumerate(top_adopters, 1):
                    print(f"   {i}. {adopter['adp_name']} ({adopter['city']})")
                    print(f"      Applications: {adopter['total_applications']} | Approved: {adopter['approved']}")
            
            print("\n" + "="*60)
            print("📊 End of Statistical Report")
            print("="*60)
            
        except Exception as e:
            print(f"❌ Error generating report: {e}")
    
    def close(self):
        """Close database connection"""
        self.db.disconnect()